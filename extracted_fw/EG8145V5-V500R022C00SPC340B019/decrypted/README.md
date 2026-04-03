# EG8145V5 Firmware - Decrypted & Decoded Contents

## Firmware: V500R022C00SPC340B019

**Total extracted files: 3364**

## Summary

| Category | Files |
|----------|-------|
| Application Configs | 49 |
| Boot Scripts | 2 |
| Decoded Binary Data Models | 67 |
| Decoded Type Trees | 1 |
| Documentation | 2 |
| EFS (Equipment Fabrication Sheet) | 1 |
| Feature Toggle Configs | 138 |
| ISP Customization Configs | 773 |
| MTD Partition Data | 5 |
| Main Web UI (.asp/.js/.css/.html) | 1981 |
| ONT Hardware Configs | 44 |
| Plugin Configs & Certificates | 8 |
| Plugin Package (from kernelapp.cpk) | 35 |
| Plugin Web UI (from webs.tar.gz) | 53 |
| SDK SquashFS (from mtd10) | 6 |
| Specification Files | 54 |
| System Scripts | 3 |
| TTree Spec Smooth (encrypted) | 1 |
| WAP Core Configs | 141 |
| **TOTAL** | **3364** |

## Key Files

| File | Description |
|------|-------------|
| [`plaintext/etc/wap/hw_cli.xml`](plaintext/etc/wap/hw_cli.xml) | Complete CLI command definitions (4743 lines, all WAP commands) |
| [`plaintext/etc/wap/hw_aes_tree.xml`](plaintext/etc/wap/hw_aes_tree.xml) | AES encryption field map (100+ password fields) |
| [`plaintext/etc/wap/hw_boardinfo`](plaintext/etc/wap/hw_boardinfo) | Hardware board information |
| [`plaintext/etc/wap/passwd`](plaintext/etc/wap/passwd) | System user accounts (22 users) |
| [`plaintext/etc/wap/customize/common/spec_telmex.cfg`](plaintext/etc/wap/customize/common/spec_telmex.cfg) | Telmex/Megacable ISP customization |
| [`extracted_archives/kernelapp_cpk/`](extracted_archives/kernelapp_cpk/) | Plugin package with SSL certs, scripts, binary info |
| [`extracted_archives/webs_plugin/`](extracted_archives/webs_plugin/) | Plugin web UI (diagnose, QR code, WiFi position) |
| [`extracted_archives/efs_decoded.txt`](extracted_archives/efs_decoded.txt) | EFS: OLT=MA5600, Equipment=H801EPBA |
| [`extracted_archives/mtd_partitions/UpgradeCheck.xml`](extracted_archives/mtd_partitions/UpgradeCheck.xml) | Hardware compatibility and upgrade validation |
| [`hw_ttree.decoded.txt`](hw_ttree.decoded.txt) | Full data model type tree (21,916 nodes) |
| [`web_ui/`](web_ui/) | Complete web administration interface (1,981 files) |
| [`ENCRYPTED_FILES.md`](ENCRYPTED_FILES.md) | Documentation of 9 encrypted files + decryption script |

## Extracted Archives

| Archive | Source | Contents |
|---------|--------|----------|
| `webs.tar.gz` | MyPlugin/etc/res/ | 53 web UI files (HTML, JS, CSS, PNG) |
| `kernelapp.cpk` | preload_cplugin/ | 35 files (binaries, configs, scripts, SSL certs) |
| SquashFS SDK | mtd10 | 6 files (codec drivers, VoIP firmware blobs) |
| `preload_cplugin.tar` | mtd9 | Plugin package (decompressed from .tar.gz) |

## Encrypted Files (9 files, need device key)

See [`ENCRYPTED_FILES.md`](ENCRYPTED_FILES.md) for complete documentation,
format specification, and decryption script.
