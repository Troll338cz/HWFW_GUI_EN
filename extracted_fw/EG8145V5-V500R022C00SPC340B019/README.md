# Firmware Extraction: EG8145V5-V500R022C00SPC340B019.bin

## Overview

- **Device**: Huawei EG8145V5 (ONT GPON)
- **Firmware Version**: V500R022C00SPC340B019
- **Source**: [Firmware-ONT-Huawei](https://github.com/muh-ramadhan/Firmware-ONT-Huawei/blob/main/Huawei%20EG8145V5/EG8145V5-V500R022C00SPC340B019.bin)
- **File Size**: 42,959,989 bytes (40.97 MB)
- **Magic**: 0x504E5748 (HWNP)
- **File CRC32**: 0x9F0A6691
- **Header CRC32**: 0x01639618
- **Number of Items**: 13

## Product List

```
159D|;COMMON|CHINA|CMCC|
```

## Extracted MTD Blocks

| # | Type | Path | Size | CRC32 Valid | Filename |
|---|------|------|------|-------------|----------|
| 0 | UPGRDCHECK | `file:/var/UpgradeCheck.xml` | 2,633 B | ✓ | `mtd0_UPGRDCHECK_var_UpgradeCheck.xml.bin` |
| 1 | SIGNINFO | `flash:signinfo` | 16,384 B | ✓ | `mtd1_SIGNINFO_signinfo.bin` |
| 2 | UBOOT | `flash:uboot` | 503,808 B (0.48 MB) | ✓ | `mtd2_UBOOT_uboot.bin` |
| 3 | KERNEL | `flash:kernel` | 2,138,112 B (2.04 MB) | ✓ | `mtd3_KERNEL_kernel.bin` |
| 4 | ROOTFS | `flash:rootfs` | 38,137,856 B (36.37 MB) | ✓ | `mtd4_ROOTFS_rootfs.bin` |
| 5 | UPDATEFLAG | `file:/mnt/jffs2/Updateflag` | 2 B | ✓ | `mtd5_UPDATEFLAG_mnt_jffs2_Updateflag.bin` |
| 6 | UNKNOWN | `file:/mnt/jffs2/ttree_spec_smooth.tar.gz` | 8,712 B | ✓ | `mtd6_UNKNOWN_mnt_jffs2_ttree_spec_smooth.tar.gz.bin` |
| 7 | UNKNOWN | `file:/var/setequiptestmodeoff` | 791 B | ✓ | `mtd7_UNKNOWN_var_setequiptestmodeoff.bin` |
| 8 | UNKNOWN | `file:/var/dealcplgin.sh` | 244 B | ✓ | `mtd8_UNKNOWN_var_dealcplgin.sh.bin` |
| 9 | UNKNOWN | `file:/mnt/jffs2/app/preload_cplugin.tar.gz` | 2,047,991 B (1.95 MB) | ✓ | `mtd9_UNKNOWN_mnt_jffs2_app_preload_cplugin.tar.gz.bin` |
| 10 | sdk | `file:/mnt/jffs2/sdkfs` | 98,388 B | ✓ | `mtd10_sdk_mnt_jffs2_sdkfs.bin` |
| 11 | UNKNOWN | `file:/mnt/jffs2/plugin_timestamp` | 28 B | ✓ | `mtd11_UNKNOWN_mnt_jffs2_plugin_timestamp.bin` |
| 12 | EFS | `file:/var/efs` | 68 B | ✓ | `mtd12_EFS_var_efs.bin` |

All 13 items extracted with CRC32 verification passing ✓

## Extracted Contents (`contents/` directory)

Internal payloads extracted from MTD blocks (HW/uImage headers stripped):

| File | Description | Size |
|------|-------------|------|
| `mtd0_UPGRDCHECK_var_UpgradeCheck.xml.xml` | Upgrade check XML config | 2,633 B |
| `mtd1_SIGNINFO_signinfo_payload.bin` | Signature info (HW header stripped) | 16,300 B |
| `mtd2_UBOOT_uboot_payload.bin` | U-Boot bootloader binary (ARM) | 503,724 B |
| `mtd3_KERNEL_kernel_payload.bin` | Linux 5.10.0 kernel (bzip2 compressed) | 2,133,576 B |
| `mtd4_ROOTFS_rootfs_payload.bin` | SquashFS root filesystem (bzip2 compressed) | 38,131,040 B |
| `mtd7_UNKNOWN_var_setequiptestmodeoff.sh` | Shell script: equipment test mode off | 791 B |
| `mtd8_UNKNOWN_var_dealcplgin.sh.sh` | Shell script: cplugin handler | 244 B |
| `mtd9_..._cplugin.tar.gz.tar.gz` | Cplugin preload archive (gzip) | 2,047,991 B |
| `mtd9_..._decompressed.tar` | Cplugin preload archive (decompressed) | 2,058,240 B |
| `mtd10_sdk_mnt_jffs2_sdkfs_squashfs.bin` | SDK SquashFS filesystem | 98,304 B |
| `mtd11_..._plugin_timestamp.txt` | Plugin timestamp: V500R022C00SPC340A2402080348 | 28 B |

## Item Details

### MTD0: UPGRDCHECK (`file:/var/UpgradeCheck.xml`)
- XML file containing hardware version check configuration
- Lists supported BoardIds for firmware upgrade validation

### MTD1: SIGNINFO (`flash:signinfo`)
- HW header: `V500R022C00SPC340B019 | SIGNINFO`
- Contains firmware signature/verification data

### MTD2: UBOOT (`flash:uboot`)
- HW header: `V500R022C00SPC340B019 | UBOOT`
- ARM U-Boot bootloader binary (503 KB)

### MTD3: KERNEL (`flash:kernel`)
- HW header: `V500R022C00SPC340B019 | KERNEL`
- uImage: `Linux-5.10.0`, bzip2 compressed
- Load address: 0x80E08000, Entry point: 0x80E08000

### MTD4: ROOTFS (`flash:rootfs`)
- HW header: `V500R022C00SPC340B019`
- uImage: `squashfs`, bzip2 compressed
- Full SquashFS root filesystem (36.37 MB)

### MTD5: UPDATEFLAG (`file:/mnt/jffs2/Updateflag`)
- 2-byte update flag (`N\n`)

### MTD6: UNKNOWN (`file:/mnt/jffs2/ttree_spec_smooth.tar.gz`)
- Encrypted/signed tree specification data

### MTD7: Shell Script (`file:/var/setequiptestmodeoff`)
- Script to disable equipment test mode

### MTD8: Shell Script (`file:/var/dealcplgin.sh`)
- Script to handle cplugin preload installation

### MTD9: Cplugin (`file:/mnt/jffs2/app/preload_cplugin.tar.gz`)
- Compressed tar.gz archive containing cplugin preload data (1.95 MB)

### MTD10: SDK (`file:/mnt/jffs2/sdkfs`)
- HW header: `sdk:data`
- SquashFS filesystem containing SDK files (96 KB)

### MTD11: Plugin Timestamp (`file:/mnt/jffs2/plugin_timestamp`)
- Version string: `V500R022C00SPC340A2402080348`

### MTD12: EFS (`file:/var/efs`)
- Equipment Firmware System data (68 bytes)
- Contains device identification: MA5600, H801EPBA

---

*Extracted using HWNP firmware parser based on [HWFW_GUI](https://github.com/Uaemextop/HWFW_GUI_EN)*
