#!/usr/bin/env python3
"""
Huawei EG8145V5 ONT Firmware Update Downloader & Analyzer
==========================================================
All URLs, endpoints, headers and protocol details were extracted
from the local firmware binaries (V500R022C00SPC340B019) using
Capstone disassembly and string analysis.

The ONT uses multiple update channels. This script replicates
the HTTP/HTTPC download channel behavior as found in:
  - libhw_swm_dll.so        (SWM download channels)
  - libhw_smp_httpclient.so  (HTTP client: headers, auth, download)
  - libhw_smp_mobilemng_upgrade.so (mobile management upgrade)
  - libhw_srv_comm_smp.so    (service comm: URL parsing, HTTPC format)

Usage:
  # Check current firmware version on the ONT
  python3 hw_fw_downloader.py --target 192.168.1.1 --check-version

  # Download firmware from ONT's own web interface
  python3 hw_fw_downloader.py --target 192.168.1.1 --download-config

  # Query update pop-up window status
  python3 hw_fw_downloader.py --target 192.168.1.1 --check-update-pop

  # Download firmware via TR-069/CWMP URL (as ONT does internally)
  python3 hw_fw_downloader.py --cwmp-download http://acs-server/firmware.bin -o firmware.bin

  # Probe ONT endpoints for version and upgrade info
  python3 hw_fw_downloader.py --target 192.168.1.1 --probe-all

  # Extract all URLs and endpoints from a local firmware binary
  python3 hw_fw_downloader.py --extract-urls /path/to/libhw_swm_dll.so
"""

import argparse
import hashlib
import json
import os
import re
import socket
import struct
import subprocess
import sys
import time
import urllib.parse
import xml.etree.ElementTree as ET
from pathlib import Path

try:
    import requests
    HAS_REQUESTS = True
except ImportError:
    HAS_REQUESTS = False

# ============================================================================
# DATA EXTRACTED FROM FIRMWARE BINARIES (LOCAL ANALYSIS ONLY)
# ============================================================================

# --- URLs and endpoints found in firmware binaries ---
# Source: strings analysis of libhw_srv_comm_smp.so, libhw_smp_mobilemng_upgrade.so

# Update configuration page (checks if update is available)
# Pattern: http://%s/updateConfig.asp  or  http://%s:%u/updateConfig.asp
ENDPOINT_UPDATE_CONFIG = "/updateConfig.asp"

# Update pop-up window (user notification about available update)
# Pattern: http://%s/updatePopWindow.asp  or  http://%s:%u/updatePopWindow.asp
ENDPOINT_UPDATE_POP = "/updatePopWindow.asp"

# Firmware upgrade CGI endpoint (web UI upload)
# Pattern: http://192.168.1.1/upgrade.cgi (hardcoded in libl2_ext.so)
ENDPOINT_UPGRADE_CGI = "/upgrade.cgi"

# Framework upgrade CGI
# Source: libhw_pdt_web_osgi.so
ENDPOINT_FMK_UPGRADE = "/FmkUpgrade.cgi"

# Other CGI endpoints found in libhw_swm_dll.so web handler
ENDPOINT_DOWNLOAD_FILE = "/downloadfile.cgi"
ENDPOINT_DOWNLOAD_COMMON = "/downloadcommonfile.cgi"
ENDPOINT_CERT_MGMT = "/certManagement.cgi"
ENDPOINT_SET = "/set.cgi"
ENDPOINT_GET_AJAX = "/getajax.cgi"
ENDPOINT_INFORM = "/inform.cgi"

# Login endpoints
ENDPOINT_LOGIN = "/login.cgi"
ENDPOINT_LOGIN_ASP = "/login.asp"
ENDPOINT_INDEX = "/index.asp"

# Version and status pages
ENDPOINT_GET_VERSION = "/html/frame_huawei/asp/GetAppVersion.asp"
ENDPOINT_REFRESH = "/refresh.asp"
ENDPOINT_UPDATE_NOTE = "/html/frame_huawei/updateNote.asp"

# --- HTTP Headers used by the ONT's HTTP client ---
# Source: strings from libhw_smp_httpclient.so

HEADERS_DOWNLOAD = {
    "User-Agent": "Huawei",
    "Accept": "application/x-ms-application, image/jpeg, application/xaml+xml, "
              "image/gif, image/pjpeg, application/x-ms-xbap, "
              "application/vnd.ms-excel, application/vnd.ms-powerpoint, "
              "application/msword, application/x-shockwave-flash, */*",
    "Accept-Language": "en",
    "Connection": "Keep-Alive",
}

HEADERS_UPLOAD = {
    "User-Agent": "Huawei",
    "Content-Type": "multipart/form-data; boundary=---------------------------7d61ffc140e5a",
    "Connection": "Keep-Alive",
}

HEADERS_JSON = {
    "User-Agent": "Huawei",
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Connection": "Keep-Alive",
}

# Content types found in libhw_smp_httpclient.so
CONTENT_TYPES = {
    "firmware": "application/octet-stream",
    "form": "application/x-www-form-urlencoded",
    "json": "application/json",
    "multipart": "multipart/form-data; boundary=---------------------------7d61ffc140e5a",
}

# Multipart boundary used for file uploads
# Source: libhw_smp_httpclient.so
UPLOAD_BOUNDARY = "---------------------------7d61ffc140e5a"

# --- Authentication ---
# Source: libhw_smp_httpclient.so (HTTPAuthor_ClientAuthor, HTTP_AuthorCalculateAdapt)
# The ONT HTTP client supports both Basic and Digest authentication
# Digest auth fields: username, realm, nonce, cnonce, nc, qop, opaque

# --- Download info XML format ---
# Source: libhw_smp_mobilemng_upgrade.so
# Stored at: /mnt/jffs2/upgrade_info.xml and /mnt/jffs2/downloadinfo
DOWNLOAD_INFO_XML_TEMPLATE = """<?xml version="1.0" encoding="UTF-8"?>
<downverinfo>
  <downurl>{url}</downurl>
  <filetype>{filetype}</filetype>
  <taskID>{task_id}</taskID>
  <finish_flag>{finish_flag}</finish_flag>
</downverinfo>
"""

# --- CLI download commands used by the ONT ---
# Source: libhw_swm_dll.so (HW_SWM_CHNL_*_Download functions)

# HTTPC download (TR-069/CWMP channel):
#   httpc -g -D -i -l <local_file> <url>     (HTTP with Digest auth)
#   httpc -g -i -l <local_file> <url>         (HTTP without Digest)
#   (httpc -s -l <local_file> <url>)          (HTTPS)

# TFTP download:
#   tftp -i -l "<local>" -r <remote> -g "<server>";echo $?>/var/swmresult.txt

# FTP download:
#   ftpget "<server>" "<local>" <remote> <user> <pass> -i -d

# SFTP download:
#   psftp get "<remote>" <local> "<server>" <options>;echo $?>/var/swmresult.txt

# --- Firmware file paths on the ONT ---
# Source: libhw_swm_dll.so, libhw_smp_mobilemng_upgrade.so
FW_PATHS = {
    "firmware_image": "/var/firmware1.tar.gz",
    "upload_temp": "/var/TempUpload.bin",
    "upgrade_info": "/mnt/jffs2/upgrade_info.xml",
    "download_info": "/mnt/jffs2/downloadinfo",
    "download_only": "/mnt/jffs2/downloadonly",
    "update_flag": "/mnt/jffs2/Updateflag",
    "update_flag_tmp": "/var/updateflagtmp",
    "upgrade_flag": "/tmp/upgradeflag",
    "commit_upgrade": "/mnt/jffs2/commitupgrade",
    "reboot_upgrade": "/mnt/jffs2/rebootupgrade",
    "end_download": "/mnt/jffs2/enddownload",
    "upgrade_sw_ver": "/var/UpgradeSWVersion",
    "upgrade_same": "/var/upgrade_same",
    "upgrade_no_fail": "/var/upgrade_no_fail",
    "nce_batch_info": "/var/nceBatchUpgradeInfo",
    "specified_info": "/var/specifiedUpgradeInfo",
    "batch_info": "/var/batchUpgradeInfo",
    "swm_result": "/var/swmresult.txt",
    "swm_fifo": "/var/swm_receive_fifo",
    "nce_download_flag": "/var/nce_download_flag",
    "image_file": "/mnt/jffs2/imageFile.bin",
    "main_version": "/mnt/jffs2/main_version",
    "hard_version": "/mnt/jffs2/hard_version",
    "osgi_upgrade": "/mnt/jffs2/app/osgi_upgrade.tar.gz",
    "plugin_upgrade": "/mnt/jffs2/app/plugin_upgrade",
    "upgrade_check": "/var/UpgradeCheck.xml",
    "flash_cfg": "/var/hw_flashcfg.xml",
}

# --- TR-069 data model paths ---
# Source: libhw_swm_dll.so, libhw_srv_comm_smp.so
TR069_PATHS = {
    "mgmt_server": "InternetGatewayDevice.ManagementServer",
    "conn_req_url": "InternetGatewayDevice.ManagementServer.ConnectionRequestURL",
    "conn_req_user": "InternetGatewayDevice.ManagementServer.ConnectionRequestUsername",
    "conn_req_pass": "InternetGatewayDevice.ManagementServer.ConnectionRequestPassword",
    "download_url": "InternetGatewayDevice.DownloadDiagnostics.DownloadURL",
    "sw_version": "SoftwareVersion",
    "hw_version": "HardwareVersion",
    "default_conn": "InternetGatewayDevice.Layer3Forwarding.DefaultConnectionService",
    "wan_device": "InternetGatewayDevice.WANDevice.1.WANConnectionDevice",
}

# --- Feature flags controlling updates ---
# Source: libhw_swm_product.so
FEATURE_FLAGS = {
    "FT_USB_AUTO_UPGRADE": "USB auto-upgrade at boot",
    "FT_HGW_UPGRADE_AP": "Home Gateway AP upgrade",
    "FT_UPGRADE_DELAY_REBOOT": "Delay reboot after upgrade",
    "FT_K662C_UPGRADE_LIMIT": "K662c MTD layout restriction",
    "FT_FACTORY_DOWNGRADE_LIMIT": "Block downgrade below factory version",
    "FT_SSMP_AIS_DOWNGRADE_CHECK": "AIS downgrade prevention",
    "FT_CWMP_OPTION43_URL_CONTROL": "DHCP Option 43 ACS URL",
}


# ============================================================================
# URL AND ENDPOINT EXTRACTION FROM LOCAL BINARIES
# ============================================================================

def extract_urls_from_binary(filepath):
    """Extract all URLs, endpoints, and server references from a firmware binary."""
    try:
        with open(filepath, 'rb') as f:
            data = f.read()
    except (IOError, OSError) as e:
        print(f"[!] Cannot read {filepath}: {e}")
        return {}

    text = data.decode('ascii', errors='ignore')

    results = {
        "http_urls": set(),
        "https_urls": set(),
        "url_templates": set(),
        "asp_endpoints": set(),
        "cgi_endpoints": set(),
        "api_paths": set(),
        "ip_addresses": set(),
        "hostnames": set(),
        "download_commands": set(),
        "file_paths": set(),
        "xml_tags": set(),
        "http_headers": set(),
        "content_types": set(),
    }

    # Extract HTTP/HTTPS URLs
    for match in re.finditer(r'https?://[^\s\x00-\x1f"<>{}|\\^`]{3,200}', text):
        url = match.group().rstrip(".,;:)'\"")
        if '%s' in url or '%u' in url or '%d' in url:
            results["url_templates"].add(url)
        elif url.startswith("https://"):
            results["https_urls"].add(url)
        else:
            results["http_urls"].add(url)

    # Extract .asp endpoints
    for match in re.finditer(r'/[\w/]+\.asp\b', text):
        results["asp_endpoints"].add(match.group())

    # Extract .cgi endpoints
    for match in re.finditer(r'/?\w+\.cgi\b', text):
        results["cgi_endpoints"].add(match.group())

    # Extract IP addresses
    for match in re.finditer(r'\b(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\b', text):
        ip = match.group(1)
        parts = ip.split('.')
        if all(0 <= int(p) <= 255 for p in parts):
            results["ip_addresses"].add(ip)

    # Extract download commands (httpc, tftp, ftpget, psftp)
    for match in re.finditer(r'(httpc|tftp|ftpget|ftpput|psftp|wget|curl)\s+[^\x00-\x1f]{5,200}', text):
        results["download_commands"].add(match.group().strip())

    # Extract file paths related to updates
    for match in re.finditer(r'(/(?:var|mnt|tmp|etc|opt|data)/[\w/.+-]{3,100})', text):
        path = match.group(1)
        if any(kw in path.lower() for kw in ['upgrade', 'update', 'download', 'firmware',
                                               'version', 'swm', 'image', 'flash', 'cfg',
                                               'cert', 'load', 'plugin', 'osgi', 'nce',
                                               'batch', 'specified']):
            results["file_paths"].add(path)

    # Extract XML tags
    for match in re.finditer(r'<(\w+)>[^<]*</\1>', text):
        results["xml_tags"].add(match.group())

    # Extract HTTP headers
    for match in re.finditer(r'(Host|User-Agent|Content-Type|Accept|Authorization|'
                              r'Connection|Cache-Control|Range|Accept-Encoding|'
                              r'Accept-Language|Content-Length|Content-Disposition|'
                              r'Proxy-Authorization|WWW-Authenticate|PROXY-Authenticate)'
                              r'[:\s][^\x00-\x1f]{1,200}', text):
        results["http_headers"].add(match.group().strip())

    # Extract content types
    for match in re.finditer(r'(application|text|multipart|image)/[\w.+*/-]{3,80}', text):
        results["content_types"].add(match.group())

    return results


def print_extracted_data(results, filepath):
    """Print extracted URL/endpoint data in a formatted way."""
    print(f"\n{'='*70}")
    print(f"  URLs & ENDPOINTS EXTRACTED FROM: {os.path.basename(filepath)}")
    print(f"{'='*70}")

    sections = [
        ("URL Templates (dynamic)", "url_templates"),
        ("HTTP URLs", "http_urls"),
        ("HTTPS URLs", "https_urls"),
        ("ASP Endpoints", "asp_endpoints"),
        ("CGI Endpoints", "cgi_endpoints"),
        ("IP Addresses", "ip_addresses"),
        ("Download Commands", "download_commands"),
        ("Update-related File Paths", "file_paths"),
        ("HTTP Headers", "http_headers"),
        ("Content Types", "content_types"),
        ("XML Tags", "xml_tags"),
    ]

    for title, key in sections:
        items = sorted(results.get(key, set()))
        if items:
            print(f"\n  [{title}] ({len(items)} found)")
            for item in items:
                print(f"    {item}")


# ============================================================================
# ONT COMMUNICATION (using data extracted from firmware)
# ============================================================================

def build_url(host, port, endpoint, https=False):
    """Build URL using the same pattern as libhw_srv_comm_smp.so."""
    scheme = "https" if https else "http"
    if port and port not in (80, 443):
        # Pattern: http://%s:%u/updateConfig.asp
        return f"{scheme}://{host}:{port}{endpoint}"
    else:
        # Pattern: http://%s/updateConfig.asp
        return f"{scheme}://{host}{endpoint}"


def make_digest_auth_header(username, realm, nonce, uri, cnonce, nc, qop, opaque, password):
    """
    Build Digest auth header as implemented in libhw_smp_httpclient.so.
    HTTPAuthor_ClientAuthor function at 0x0000d440.

    Header format from firmware:
      Proxy-Authorization: Digest username="%s", realm="%s", nonce="%s",
                           cnonce="%s", nc=%s, qop="%s", opaque="%s"
    """
    ha1 = hashlib.md5(f"{username}:{realm}:{password}".encode()).hexdigest()
    ha2 = hashlib.md5(f"GET:{uri}".encode()).hexdigest()
    response = hashlib.md5(f"{ha1}:{nonce}:{nc}:{cnonce}:{qop}:{ha2}".encode()).hexdigest()

    return (f'Digest username="{username}", realm="{realm}", '
            f'nonce="{nonce}", uri="{uri}", '
            f'cnonce="{cnonce}", nc={nc}, qop="{qop}", '
            f'opaque="{opaque}", response="{response}"')


def check_version(host, port=80):
    """
    Query the ONT for its current firmware version.
    Uses the GetAppVersion.asp endpoint found in the firmware.
    """
    if not HAS_REQUESTS:
        return _check_version_raw(host, port)

    url = build_url(host, port, ENDPOINT_GET_VERSION)
    print(f"[*] Querying firmware version at: {url}")

    try:
        resp = requests.get(url, headers=HEADERS_DOWNLOAD, timeout=10, verify=False)
        print(f"[*] Status: {resp.status_code}")
        if resp.status_code == 200:
            print(f"[*] Response:\n{resp.text[:2000]}")
            # Try to parse version from response
            ver_match = re.search(r'V\d+R\d+C\d+SPC\d+', resp.text)
            if ver_match:
                print(f"\n[+] Firmware Version: {ver_match.group()}")
            return resp.text
        elif resp.status_code == 401:
            print("[!] Authentication required (login first)")
        elif resp.status_code == 404:
            print("[!] Endpoint not found, trying alternative...")
            return _try_alternative_version(host, port)
    except requests.exceptions.RequestException as e:
        print(f"[!] Connection error: {e}")
    return None


def _check_version_raw(host, port=80):
    """Raw socket version check without requests library."""
    url_path = ENDPOINT_GET_VERSION
    request = (
        f"GET {url_path} HTTP/1.1\r\n"
        f"Host:{host}\r\n"
        f"User-Agent: Huawei\r\n"
        f"Accept: */*\r\n"
        f"Connection: close\r\n"
        f"\r\n"
    )
    try:
        with socket.create_connection((host, port), timeout=10) as sock:
            sock.sendall(request.encode())
            response = b""
            while True:
                chunk = sock.recv(4096)
                if not chunk:
                    break
                response += chunk
            decoded = response.decode('utf-8', errors='replace')
            print(f"[*] Raw response:\n{decoded[:2000]}")
            return decoded
    except (socket.error, OSError) as e:
        print(f"[!] Socket error: {e}")
    return None


def _try_alternative_version(host, port):
    """Try alternative endpoints for version info."""
    alternatives = [
        ENDPOINT_INDEX,
        ENDPOINT_LOGIN_ASP,
        ENDPOINT_REFRESH,
        "/html/frame_huawei/infopage.asp",
    ]
    for ep in alternatives:
        url = build_url(host, port, ep)
        print(f"  [*] Trying: {url}")
        try:
            resp = requests.get(url, headers=HEADERS_DOWNLOAD, timeout=5, verify=False)
            if resp.status_code == 200:
                ver_match = re.search(r'V\d+R\d+C\d+SPC\d+', resp.text)
                if ver_match:
                    print(f"  [+] Found version: {ver_match.group()}")
                    return resp.text
        except requests.exceptions.RequestException:
            continue
    return None


def check_update_pop(host, port=80):
    """
    Check the update pop-up window status.
    This is how the ONT notifies users about available updates.

    Source: libhw_smp_mobilemng_upgrade.so
      HW_Mobilemng_Get_UpradePopUrl → http://%s/updatePopWindow.asp
      HW_Mobilemng_Get_UpradePopCfgUrl → http://%s/updateConfig.asp

    The pop-up functions:
      HW_WEB_AgreePopUpgrade   → user agrees to upgrade
      HW_WEB_RefusePopUpgrade  → user refuses upgrade
      HW_WEB_RemindPopUpgrade  → remind later

    Source: libhw_web_dll.so
    """
    if not HAS_REQUESTS:
        print("[!] 'requests' library required. Install: pip install requests")
        return None

    # Check updatePopWindow.asp
    url_pop = build_url(host, port, ENDPOINT_UPDATE_POP)
    url_cfg = build_url(host, port, ENDPOINT_UPDATE_CONFIG)

    print(f"[*] Checking update pop-up: {url_pop}")
    try:
        resp = requests.get(url_pop, headers=HEADERS_DOWNLOAD, timeout=10, verify=False)
        print(f"[*] Pop-up status: {resp.status_code}")
        if resp.status_code == 200:
            print(f"[*] Pop-up response:\n{resp.text[:2000]}")
    except requests.exceptions.RequestException as e:
        print(f"[!] Pop-up error: {e}")

    print(f"\n[*] Checking update config: {url_cfg}")
    try:
        resp = requests.get(url_cfg, headers=HEADERS_DOWNLOAD, timeout=10, verify=False)
        print(f"[*] Config status: {resp.status_code}")
        if resp.status_code == 200:
            print(f"[*] Config response:\n{resp.text[:2000]}")
            return resp.text
    except requests.exceptions.RequestException as e:
        print(f"[!] Config error: {e}")

    return None


def download_via_httpc(url, output_file, use_https=False, use_digest=False):
    """
    Download firmware using the same method as the ONT's HTTPC channel.

    The ONT builds these commands in HW_SWM_CHNL_HTTPC_FormatCmd @ 0x0001fa10:
      httpc -g -D -i -l <local_file> <url>   (with Digest auth, -D flag)
      httpc -g -i -l <local_file> <url>       (without Digest)
      (httpc -s -l <local_file> <url>)        (HTTPS, -s flag)

    The httpc binary internally uses libhw_smp_httpclient.so which sends:
      GET <path> HTTP/1.1
      Host:<host> or Host:<host>:<port>  or Host:[<ipv6>] or Host:[<ipv6>]:<port>
      User-Agent: Huawei
      Accept: <accept_string>
      Accept-Language: en
      Connection: Keep-Alive
      Range: bytes=<start>-<end>  (for segmented downloads)
      Authorization: Digest ...   (if -D flag and server requires it)

    Download flow from firmware analysis:
      1. DOWNLOAD_StartDownloadData → HW_HTTP_ClientStartDownloadWithLocalIp
      2. Download_MainProcess → CLIENT_SendHeader (sends GET + headers)
      3. DOWNLOAD_ClientCallBack → DOWNLOAD_WriteData → DOWNLOAD_KerWriteData
      4. Result written to /var/swmresult.txt
    """
    if not HAS_REQUESTS:
        print("[!] 'requests' library required. Install: pip install requests")
        return False

    headers = HEADERS_DOWNLOAD.copy()

    # Parse URL components as done by HW_SRV_SMP_GetBasicInfoFromURL
    parsed = urllib.parse.urlparse(url)
    host = parsed.hostname
    port = parsed.port
    path = parsed.path or "/"

    # Set Host header as libhw_smp_httpclient.so does
    # Pattern: Host:%s (no port) or Host:%s:%u (with port)
    if port and port not in (80, 443):
        headers["Host"] = f"{host}:{port}"
    else:
        headers["Host"] = host

    print(f"[*] HTTPC Download Channel")
    print(f"[*] URL: {url}")
    print(f"[*] Output: {output_file}")
    print(f"[*] HTTPS: {use_https}, Digest Auth: {use_digest}")
    print(f"[*] Headers being sent (as per libhw_smp_httpclient.so):")
    for k, v in headers.items():
        print(f"    {k}: {v}")

    try:
        session = requests.Session()

        # First request (may get 401 if auth required)
        resp = session.get(url, headers=headers, stream=True, timeout=30, verify=False)

        if resp.status_code == 401 and use_digest:
            print("[*] Server requires authentication (401)")
            # The ONT would use Digest auth here via HTTPAuthor_ClientAuthor
            print("[!] Digest auth parameters needed from server's WWW-Authenticate header")
            www_auth = resp.headers.get('WWW-Authenticate', '')
            print(f"[*] WWW-Authenticate: {www_auth}")
            return False

        if resp.status_code == 200:
            total_size = int(resp.headers.get('Content-Length', 0))
            print(f"[*] Content-Length: {total_size} bytes")
            print(f"[*] Content-Type: {resp.headers.get('Content-Type', 'unknown')}")

            downloaded = 0
            with open(output_file, 'wb') as f:
                for chunk in resp.iter_content(chunk_size=8192):
                    if chunk:
                        f.write(chunk)
                        downloaded += len(chunk)
                        if total_size > 0:
                            pct = (downloaded / total_size) * 100
                            print(f"\r[*] Progress: {downloaded}/{total_size} ({pct:.1f}%)",
                                  end='', flush=True)

            print(f"\n[+] Download complete: {downloaded} bytes saved to {output_file}")

            # Write result like the ONT does
            # echo $?>/var/swmresult.txt
            print(f"[*] (ONT would write '0' to {FW_PATHS['swm_result']})")
            return True
        else:
            print(f"[!] HTTP error: {resp.status_code}")
            return False

    except requests.exceptions.RequestException as e:
        print(f"[!] Download error: {e}")
        return False


def download_via_web(host, port=80, output_file="firmware_backup.bin"):
    """
    Download current firmware configuration from the ONT's web interface.

    Uses downloadfile.cgi endpoint found in libhw_swm_dll.so:
      HW_WEB_DownloadRequestProc → HW_WEB_DownloadFileFromSWM
    """
    if not HAS_REQUESTS:
        print("[!] 'requests' library required. Install: pip install requests")
        return False

    url = build_url(host, port, ENDPOINT_DOWNLOAD_FILE)
    print(f"[*] Downloading from: {url}")

    try:
        resp = requests.get(url, headers=HEADERS_DOWNLOAD, timeout=30, verify=False)
        if resp.status_code == 200:
            with open(output_file, 'wb') as f:
                f.write(resp.content)
            print(f"[+] Saved {len(resp.content)} bytes to {output_file}")
            return True
        else:
            print(f"[!] Status: {resp.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"[!] Error: {e}")
    return False


def upload_firmware_web(host, port, firmware_path, username=None, password=None):
    """
    Upload firmware via the web interface, replicating how the ONT's
    HW_WEB_UploadRequestProc works.

    Source: libhw_swm_dll.so, HW_WEB_UploadRequestProc @ 0x0001ede8
    The upload goes to upgrade.cgi with multipart/form-data encoding.

    Boundary from libhw_smp_httpclient.so:
      multipart/form-data; boundary=---------------------------7d61ffc140e5a

    Content-Disposition format:
      Content-Disposition: form-data; name="%s"; filename="%s"

    Upload temp file on ONT: /var/TempUpload.bin
    """
    if not HAS_REQUESTS:
        print("[!] 'requests' library required. Install: pip install requests")
        return False

    if not os.path.exists(firmware_path):
        print(f"[!] Firmware file not found: {firmware_path}")
        return False

    url = build_url(host, port, ENDPOINT_UPGRADE_CGI)
    print(f"[*] Uploading firmware to: {url}")
    print(f"[*] Firmware file: {firmware_path}")
    print(f"[*] File size: {os.path.getsize(firmware_path)} bytes")

    # The ONT expects the file in a specific multipart format
    # Content-Disposition: form-data; name="file_name"; filename="firmware.bin"
    files = {
        'file_name': (os.path.basename(firmware_path),
                      open(firmware_path, 'rb'),
                      'application/octet-stream')
    }

    headers = {"User-Agent": "Huawei"}

    try:
        session = requests.Session()

        # Login first if credentials provided
        if username and password:
            login_url = build_url(host, port, ENDPOINT_LOGIN)
            print(f"[*] Logging in to: {login_url}")
            # Login is typically form-encoded
            login_data = {"UserName": username, "PassWord": password}
            login_resp = session.post(login_url, data=login_data, headers=headers, verify=False)
            print(f"[*] Login status: {login_resp.status_code}")

        resp = session.post(url, files=files, headers=headers, timeout=120, verify=False)
        print(f"[*] Upload status: {resp.status_code}")
        if resp.status_code == 200:
            print(f"[+] Upload successful!")
            print(f"[*] Response: {resp.text[:500]}")
            return True
        else:
            print(f"[!] Upload failed: {resp.text[:500]}")
    except requests.exceptions.RequestException as e:
        print(f"[!] Upload error: {e}")
    return False


def probe_all_endpoints(host, port=80):
    """
    Probe all known update-related endpoints on the ONT.
    All endpoints extracted from local firmware analysis.
    """
    if not HAS_REQUESTS:
        print("[!] 'requests' library required. Install: pip install requests")
        return

    endpoints = [
        ("Update Config", ENDPOINT_UPDATE_CONFIG),
        ("Update Pop-up", ENDPOINT_UPDATE_POP),
        ("Upgrade CGI", ENDPOINT_UPGRADE_CGI),
        ("Framework Upgrade", ENDPOINT_FMK_UPGRADE),
        ("Download File", ENDPOINT_DOWNLOAD_FILE),
        ("Download Common", ENDPOINT_DOWNLOAD_COMMON),
        ("Version Page", ENDPOINT_GET_VERSION),
        ("Login Page", ENDPOINT_LOGIN_ASP),
        ("Index Page", ENDPOINT_INDEX),
        ("Update Note", ENDPOINT_UPDATE_NOTE),
        ("Refresh", ENDPOINT_REFRESH),
        ("Inform", ENDPOINT_INFORM),
        ("Get AJAX", ENDPOINT_GET_AJAX),
    ]

    print(f"\n{'='*70}")
    print(f"  PROBING ONT ENDPOINTS: {host}:{port}")
    print(f"  (All endpoints extracted from local firmware binaries)")
    print(f"{'='*70}\n")

    for name, endpoint in endpoints:
        url = build_url(host, port, endpoint)
        try:
            resp = requests.get(url, headers=HEADERS_DOWNLOAD, timeout=5,
                                verify=False, allow_redirects=False)
            status = resp.status_code
            size = len(resp.content)
            ct = resp.headers.get('Content-Type', 'N/A')

            marker = "+" if status == 200 else "-" if status == 404 else "?"
            print(f"  [{marker}] {status:3d} | {size:8d} bytes | {name:20s} | {endpoint}")

            if status == 200 and size > 0:
                # Look for version info
                ver = re.search(r'V\d+R\d+C\d+SPC\d+', resp.text)
                if ver:
                    print(f"        └─ Version found: {ver.group()}")

        except requests.exceptions.RequestException:
            print(f"  [!]  ERR |          | {name:20s} | {endpoint}")


def extract_all_firmware_urls(fw_root):
    """
    Extract ALL URLs and endpoints from all binaries in the firmware.
    fw_root: path to the rootfs directory.
    """
    print(f"\n{'='*70}")
    print(f"  EXTRACTING ALL URLs FROM LOCAL FIRMWARE")
    print(f"  Root: {fw_root}")
    print(f"{'='*70}")

    all_results = {
        "url_templates": set(),
        "http_urls": set(),
        "https_urls": set(),
        "asp_endpoints": set(),
        "cgi_endpoints": set(),
        "download_commands": set(),
        "file_paths": set(),
        "http_headers": set(),
        "content_types": set(),
        "ip_addresses": set(),
    }

    lib_dir = os.path.join(fw_root, "lib")
    if not os.path.isdir(lib_dir):
        print(f"[!] Library directory not found: {lib_dir}")
        return

    # Scan all .so files
    for dirpath, _, filenames in os.walk(fw_root):
        for fname in filenames:
            filepath = os.path.join(dirpath, fname)
            if fname.endswith('.so') or fname.endswith('.bin') or fname in ('busybox.suid',):
                results = extract_urls_from_binary(filepath)
                for key in all_results:
                    all_results[key] |= results.get(key, set())

    # Print combined results
    sections = [
        ("URL Templates (dynamic, %s = runtime values)", "url_templates"),
        ("Static HTTP URLs", "http_urls"),
        ("Static HTTPS URLs", "https_urls"),
        ("ASP Page Endpoints", "asp_endpoints"),
        ("CGI Script Endpoints", "cgi_endpoints"),
        ("Download Shell Commands", "download_commands"),
        ("Update-related File Paths", "file_paths"),
        ("HTTP Headers Used by ONT", "http_headers"),
        ("Content Types", "content_types"),
        ("IP Addresses", "ip_addresses"),
    ]

    for title, key in sections:
        items = sorted(all_results.get(key, set()))
        if items:
            print(f"\n  [{title}] ({len(items)} unique)")
            for item in items:
                print(f"    {item}")


# ============================================================================
# MAIN
# ============================================================================

def main():
    parser = argparse.ArgumentParser(
        description="Huawei EG8145V5 ONT Firmware Update Tool\n"
                    "All data extracted from local firmware binaries.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s --target 192.168.1.1 --check-version
  %(prog)s --target 192.168.1.1 --check-update-pop
  %(prog)s --target 192.168.1.1 --probe-all
  %(prog)s --cwmp-download http://server/firmware.bin -o firmware.bin
  %(prog)s --upload 192.168.1.1 --firmware fw.bin --user admin --pass admin
  %(prog)s --extract-urls ./extracted_fw/.../rootfs
  %(prog)s --extract-single-binary ./lib/libhw_swm_dll.so
  %(prog)s --show-headers
  %(prog)s --show-endpoints
  %(prog)s --show-paths
        """)

    parser.add_argument("--target", "-t", help="ONT IP address (default: 192.168.1.1)")
    parser.add_argument("--port", "-p", type=int, default=80, help="HTTP port (default: 80)")

    group = parser.add_mutually_exclusive_group()
    group.add_argument("--check-version", action="store_true",
                       help="Query current firmware version")
    group.add_argument("--check-update-pop", action="store_true",
                       help="Check update pop-up window status")
    group.add_argument("--download-config", action="store_true",
                       help="Download configuration from ONT")
    group.add_argument("--probe-all", action="store_true",
                       help="Probe all known update endpoints")
    group.add_argument("--cwmp-download", metavar="URL",
                       help="Download firmware via HTTPC channel (like TR-069)")
    group.add_argument("--upload", metavar="HOST",
                       help="Upload firmware to ONT")
    group.add_argument("--extract-urls", metavar="FW_ROOT",
                       help="Extract all URLs from local firmware rootfs")
    group.add_argument("--extract-single-binary", metavar="BINARY",
                       help="Extract URLs from a single binary file")
    group.add_argument("--show-headers", action="store_true",
                       help="Show HTTP headers used by the ONT")
    group.add_argument("--show-endpoints", action="store_true",
                       help="Show all known endpoints")
    group.add_argument("--show-paths", action="store_true",
                       help="Show firmware file paths on the ONT")
    group.add_argument("--show-tr069", action="store_true",
                       help="Show TR-069 data model paths")
    group.add_argument("--show-features", action="store_true",
                       help="Show feature flags controlling updates")
    group.add_argument("--show-channels", action="store_true",
                       help="Show all download channels and their commands")

    parser.add_argument("-o", "--output", default="firmware_download.bin",
                        help="Output filename for downloads")
    parser.add_argument("--firmware", help="Firmware file to upload")
    parser.add_argument("--user", help="Username for authentication")
    parser.add_argument("--pass", dest="password", help="Password for authentication")
    parser.add_argument("--https", action="store_true", help="Use HTTPS")
    parser.add_argument("--digest", action="store_true", help="Use Digest authentication")

    args = parser.parse_args()

    if not any(vars(args).values()):
        parser.print_help()
        return

    # --- Information display modes ---

    if args.show_headers:
        print("\n  HTTP HEADERS USED BY THE ONT")
        print("  Source: libhw_smp_httpclient.so\n")
        print("  [Download Headers]")
        for k, v in HEADERS_DOWNLOAD.items():
            print(f"    {k}: {v}")
        print("\n  [Upload Headers]")
        for k, v in HEADERS_UPLOAD.items():
            print(f"    {k}: {v}")
        print("\n  [JSON API Headers]")
        for k, v in HEADERS_JSON.items():
            print(f"    {k}: {v}")
        print("\n  [Authentication]")
        print("    Supports: Basic, Digest (RFC 2617)")
        print("    Digest fields: username, realm, nonce, cnonce, nc, qop, opaque")
        print("    Host header format: Host:%s or Host:%s:%u or Host:[%s] or Host:[%s]:%u")
        print("    Range support: bytes=<start>- or bytes=<start>-<end>")
        return

    if args.show_endpoints:
        print("\n  ALL KNOWN UPDATE ENDPOINTS")
        print("  Source: firmware binary analysis\n")
        endpoints = {
            ENDPOINT_UPDATE_CONFIG: "Update configuration check (libhw_srv_comm_smp.so)",
            ENDPOINT_UPDATE_POP: "Update pop-up notification (libhw_smp_mobilemng_upgrade.so)",
            ENDPOINT_UPGRADE_CGI: "Firmware upload CGI (libl2_ext.so, hardcoded 192.168.1.1)",
            ENDPOINT_FMK_UPGRADE: "Framework/plugin upgrade (libhw_pdt_web_osgi.so)",
            ENDPOINT_DOWNLOAD_FILE: "Download file from ONT (libhw_swm_dll.so)",
            ENDPOINT_DOWNLOAD_COMMON: "Download common file (libhw_swm_dll.so)",
            ENDPOINT_GET_VERSION: "Get app/firmware version (frame_huawei)",
            ENDPOINT_UPDATE_NOTE: "Update notification page (frame_huawei)",
            ENDPOINT_LOGIN: "Login CGI (libhw_web_dll.so)",
            ENDPOINT_INFORM: "Inform/notification CGI",
            ENDPOINT_CERT_MGMT: "Certificate management",
        }
        for ep, desc in endpoints.items():
            print(f"    {ep:45s} → {desc}")
        return

    if args.show_paths:
        print("\n  FIRMWARE FILE PATHS ON THE ONT")
        print("  Source: libhw_swm_dll.so, libhw_smp_mobilemng_upgrade.so\n")
        for name, path in sorted(FW_PATHS.items()):
            print(f"    {name:25s} → {path}")
        return

    if args.show_tr069:
        print("\n  TR-069/CWMP DATA MODEL PATHS")
        print("  Source: libhw_swm_dll.so, libhw_srv_comm_smp.so\n")
        for name, path in sorted(TR069_PATHS.items()):
            print(f"    {name:20s} → {path}")
        return

    if args.show_features:
        print("\n  FEATURE FLAGS CONTROLLING UPDATES")
        print("  Source: libhw_swm_product.so\n")
        for flag, desc in sorted(FEATURE_FLAGS.items()):
            print(f"    {flag:40s} → {desc}")
        return

    if args.show_channels:
        print("\n  DOWNLOAD CHANNELS & COMMANDS")
        print("  Source: libhw_swm_dll.so (HW_SWM_CHNL_* functions)\n")
        channels = [
            ("OMCI", "OLT-pushed via GPON (ME class 7)",
             "Internal RPC via HW_SWM_OAM_OMCI_RPCCall"),
            ("HTTPC", "TR-069/CWMP ACS download",
             'httpc -g -D -i -l <local> <url>\n'
             '                                      httpc -g -i -l <local> <url>\n'
             '                                      (httpc -s -l <local> <url>)  [HTTPS]'),
            ("HTTP", "Web UI browser upload",
             "POST /upgrade.cgi multipart/form-data"),
            ("FTP", "CLI-initiated FTP download",
             'ftpget "<server>" "<local>" <remote> <user> <pass> -i -d'),
            ("TFTP", "CLI-initiated TFTP download",
             'tftp -i -l "<local>" -r <remote> -g "<server>"'),
            ("SFTP", "Secure file transfer",
             'psftp get "<remote>" <local> "<server>" <opts>'),
            ("OAM", "EPON OAM download",
             "Internal via HW_SWM_OAM_OMCI_RPCCall"),
            ("OAMCTC21", "CTC 2.1 standard OAM download",
             "Internal via RPC"),
        ]
        for name, desc, cmd in channels:
            print(f"    [{name:10s}] {desc}")
            print(f"                  Command: {cmd}\n")
        return

    # --- Binary extraction modes ---

    if args.extract_urls:
        extract_all_firmware_urls(args.extract_urls)
        return

    if args.extract_single_binary:
        results = extract_urls_from_binary(args.extract_single_binary)
        print_extracted_data(results, args.extract_single_binary)
        return

    # --- Network operation modes ---

    target = args.target or "192.168.1.1"

    if args.check_version:
        check_version(target, args.port)

    elif args.check_update_pop:
        check_update_pop(target, args.port)

    elif args.download_config:
        download_via_web(target, args.port, args.output)

    elif args.probe_all:
        probe_all_endpoints(target, args.port)

    elif args.cwmp_download:
        download_via_httpc(args.cwmp_download, args.output,
                           use_https=args.https, use_digest=args.digest)

    elif args.upload:
        if not args.firmware:
            print("[!] --firmware required for upload")
            return
        upload_firmware_web(args.upload, args.port, args.firmware,
                            args.user, args.password)


if __name__ == "__main__":
    main()
