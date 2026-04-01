# sdkfs — SDK Filesystem

SquashFS 4.0 (LZMA compressed) filesystem containing DSP firmware binaries and a VoIP codec kernel module for the Lantiq/Intel XWAY VRX200 voice subsystem.

## Contents

### DSP Firmware Binaries (`etc/ont/wap/`)

These are **Lantiq/Intel PEF (POTS Endpoint Firmware)** files for the SLIC (Subscriber Line Interface Circuit) and DSP voice processing hardware.

| File | Size | Magic | Description |
|------|------|-------|-------------|
| `pef31001_zsi_firmware.bin` | 2,040 B | `0x8081` | PEF31001 ZSI (ZPSC Serial Interface) firmware — SLIC control |
| `pef31002_zsi_firmware.bin` | 3,088 B | `0x8081` | PEF31002 ZSI firmware — SLIC control for 2-channel variant |
| `pef31002_firmware.bin` | 12,360 B | `0x8081` | PEF31002 full DSP firmware — voice processing, codec support |
| `duslicxs2_130_1_0_1.bin` | 1,036 B | `0x8081` | DuSLIC-xS v2 firmware v1.30.1.0.1 — dual SLIC chip firmware |
| `dxt_fw_pef3201.bin` | 19,456 B | `0x8085` | PEF3201 (VINETIC-CPE) DXT DSP firmware — voice/fax processing |

### Kernel Module (`lib/modules/wap/`)

| File | Size | Description |
|------|------|-------------|
| `codec_sdk_le964x.ko` | 183,960 B | Lantiq LE964x codec driver — ARM ELF 32-bit, Linux 5.10.0 SMP ARMv7 |

## Hardware Context

The EG8145V5 ONT uses a **HiSilicon SD5116** SoC with integrated Lantiq voice subsystem:

- **PEF31001/31002**: SLIC (Subscriber Line Interface Circuit) — drives analog phone lines (FXS ports)
- **PEF3201 (VINETIC-CPE)**: DSP for voice/fax processing (G.711, G.729, T.38 fax relay)
- **DuSLIC-xS v2**: Dual-channel SLIC for 2-port FXS configurations
- **LE964x**: Codec chip driver for the Lantiq voice engine

### Firmware Format

All PEF firmware files use a common header format:
```
Offset  Size  Description
0x00    2     Magic (0x8081 or 0x8085)
0x02    6     Reserved/flags
0x08    4     Data size (big-endian)
0x0C    2     Entry count (4 = coefficient tables)
0x0E    2     Additional flags
0x10+   var   Register write commands (0x27XX pattern = register addresses)
```

Register writes follow the `0x27XX` pattern, where `XX` addresses specific DSP/SLIC registers for initialization, coefficient loading, and impedance matching.
