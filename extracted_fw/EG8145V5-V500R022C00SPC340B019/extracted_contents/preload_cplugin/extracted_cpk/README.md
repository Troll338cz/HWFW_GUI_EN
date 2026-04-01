# kernelapp.cpk — Extracted Contents

The `kernelapp.cpk` file is a **gzip-compressed tar archive** containing the Huawei "kernelapp" plugin — a Linux container (LXC) application that provides network management, diagnostics, and remote configuration capabilities.

## Plugin Metadata (`Info.plugin`)

| Field | Value |
|-------|-------|
| Name | kernelapp |
| Version | 22.0.77 |
| Type | app (C plugin) |
| Architecture | ARM |
| Install Size | 4,843,461 bytes |
| Kernel Version | 2.6.34.10 (compatibility) |
| LXC Container | kernelapp |
| CPU Limit | 30% |
| Memory Limit | 30,720 KB |
| Compiler | hisilinux (rtos510v2081micro) |
| Build Model | release |

## Directory Structure

```
Info.plugin                          — Plugin metadata
MyPlugin/
├── daemon.sh                        — Main daemon loop
├── plugin_startup_new.sh            — Startup script with upgrade handling
├── plugin_monitor.sh                — Process/memory/file watchdog
├── plugin_keeplive.sh               — Keepalive (8s sleep)
├── plugin_stop.sh                   — Stop script (SIGUSR2 to kernelapp)
├── BuildInfo                        — Build metadata
├── bin/
│   ├── kernelapp                    — Main application (ARM ELF, musl libc)
│   ├── cpluginapp_real              — Plugin app binary (ARM ELF, musl libc)
│   ├── opkg                         — Package manager wrapper script
│   └── opkg_real                    — opkg binary (ARM ELF, musl libc)
├── Lib/
│   ├── libsrv.so                    — Main service library (1.5 MB)
│   ├── libmbedall.so                — mbedTLS crypto (722 KB)
│   ├── libdriver_c.so               — Device driver interface (428 KB)
│   ├── libbasic.so                  — Basic utilities (413 KB)
│   ├── libcurl.so.4.7.0             — HTTP client (244 KB)
│   ├── libssh2.so.1.0.1             — SSH2 library (206 KB)
│   ├── libcivetweb.so.1.15.0        — Embedded web server (136 KB)
│   ├── libappaware.so               — App awareness (128 KB)
│   ├── libcmscbb.so                 — CMS callback (84 KB)
│   ├── libsecurec.so                — Secure C functions (63 KB)
│   ├── libubox.so                   — OpenWrt utility (59 KB)
│   ├── libcjson.so.1.7.14           — JSON parser (34 KB)
│   ├── libprotobuf-c.so.1.0.0       — Protocol Buffers (26 KB)
│   ├── libplugin_agent_api.so       — Plugin agent API (9 KB)
│   └── libextapp.so                 — External app interface (5 KB)
├── etc/
│   ├── config/
│   │   ├── kernelapp.config         — Main config (ports, SSL, MQTT settings)
│   │   ├── init_local.json          — Init configuration with encrypted params
│   │   ├── server_ssl.pem           — Server SSL certificate (Huawei ONT-Plugin)
│   │   ├── server_key_ssl.pem       — Server RSA private key (AES-256-CBC encrypted)
│   │   ├── trust_ssl.pem            — Trusted CA certificates (Huawei CA chain)
│   │   ├── restssl_info.config      — REST SSL key configuration
│   │   ├── opkg.conf                — Package manager configuration
│   │   └── useragent_feature.json   — User-Agent device classification rules
│   └── res/
│       └── webs.tar.gz              — Web UI resources (extracted below)
└── webs/                            — Extracted web UI (see below)
```

## Web UI (`webs/`)

53 files providing a mobile-friendly diagnostic web interface:

```
webs/
└── phone/
    ├── phone.html                   — Main entry point
    ├── diagnose.html                — Network diagnostics
    ├── qrcode.html                  — QR code sharing
    ├── common/                      — Shared CSS/JS (jQuery, XSS protection)
    ├── diagnose/                    — Diagnostic tool (CSS/JS/images)
    ├── potentialProblems/           — WiFi optimization/positioning tool
    └── qrCode/                      — QR code generation for WiFi sharing
```

## Security Configuration

From `kernelapp.config`:
- **MQTT**: Port 1884 (plain) / 8883 (SSL), AES encryption enabled
- **REST API**: Port 9013 (SSL) / 9011 (new SSL)
- **Local Access**: Port 27998, max 20 connections
- **SSL**: Certificate validation enabled (both cert and CRL)
- **Certificate**: Issued by "Huawei Fixed Network Product CA" (valid 2021-2036)

## Runtime Behavior

The plugin runs inside an LXC container under the `osgi_proxy:osgi` user (not root on ONT devices):
1. `daemon.sh` — Main loop: startup → monitor → keepalive → repeat
2. `plugin_startup_new.sh` — Handles first boot, upgrades, rollback scenarios
3. `plugin_monitor.sh` — Kills kernelapp if memory > 11 MB VmRSS
4. Memory check before start: requires > 5 MB free
5. Supports hot upgrade via `MyPlugin1/` staging directory
