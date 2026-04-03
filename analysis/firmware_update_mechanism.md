# Huawei EG8145V5 - Firmware Update Mechanism Analysis

## Firmware: V500R022C00SPC340B019 | Architecture: ARM 32-bit (EABI5) | Capstone 5.0.7

---

## 1. Overview: How the ONT Searches for and Applies Updates

The EG8145V5 ONT does **NOT** actively search for updates on its own. Instead, updates are **pushed** to the device through several managed channels. The update process is controlled by the **SWM (Software Management)** subsystem, composed of three core libraries:

| Library | Size | Role |
|---------|------|------|
| `libhw_swm.so` | 170 KB | Core SWM init, flash config, HTTP info, partition boot status |
| `libhw_swm_dll.so` | 412 KB | Main upgrade engine: download channels, receive/load threads, verification, CWMP integration |
| `libhw_swm_product.so` | 189 KB | Product-specific checks: version validation, hardware compatibility, LED handling |
| `libcfgupgrade.so` | 17 KB | Configuration file upgrade/migration between firmware versions |

---

## 2. Update Channels (Download Mechanisms)

The ONT supports **7 download channels**, registered during `HW_SWM_ChnlInit` and dispatched via `HW_SWM_ChnlDownload`:

### 2.1 OMCI Channel (Primary - OLT-Pushed)
- **Function**: `HW_SWM_CHNL_OMCI_Download` @ `0x0001ea60` (212 bytes)
- **Trigger**: OLT sends OMCI Software Image Download message (ME class 7)
- **Flow**: OLT → OMCI stack → `OMCI_UPD_StartDownloadProc` → `OMCI_UPD_DownloadSectionProc` → `OMCI_UPD_EndDownloadProc` → `OMCI_UPD_ActiveImageProc` → `OMCI_UPD_CommitImageProc`
- **Image file**: Written to `/mnt/jffs2/imageFile.bin`
- **Flags**: `/mnt/jffs2/commitupgrade`, `/mnt/jffs2/rebootupgrade`, `/mnt/jffs2/enddownload`
- **This is the primary ISP-controlled update method via GPON**

### 2.2 TR-069/CWMP Channel (ACS-Pushed)
- **Function**: `HW_SWM_CHNL_HTTPC_Download` @ `0x0001fd98` (116 bytes)
- **Command**: `httpc -g -D -i -l %s` or `httpc -g -i -l %s`
- **Trigger**: ACS server sends `Download` RPC with firmware URL
- **Integration**: `HW_SWM_Reply_TO_CWMP` (676 bytes), `HW_SWM_NotifyCWMPAddorDelTask`, `HW_SWM_NotifyCWMPDownloadComplete`
- **Config**: `InternetGatewayDevice.ManagementServer` with `URL`, `Username`, `Password`
- **Supports**: HTTPS with certificate validation (`HW_SWM_CWMPSSL_X509ParseCommixFile`)

### 2.3 HTTP Channel (Web UI Upload)
- **Function**: `HW_SWM_CHNL_HTTP_Download` @ `0x0001f1fc` (100 bytes)
- **Trigger**: User uploads firmware via web interface
- **Handler**: `HW_WEB_DownloadRequestProc` (456 bytes)

### 2.4 FTP Channel
- **Function**: `HW_SWM_CHNL_FTP_Download` @ `0x0001f8d0` (72 bytes)
- **Command**: `ftpput %s %s %s`
- **Used for**: CLI-initiated firmware downloads

### 2.5 TFTP Channel
- **Function**: `HW_SWM_CHNL_TFTP_Download` @ `0x0001d740` (488 bytes)
- **Command**: `tftp -i -l "%s" -r %s -g "%s";echo $?>/var/swmresult.txt`
- **Firewall**: `HW_SWM_AddTftpRule` / `HW_SWM_DelTftpRule` manage iptables rules dynamically
- **Used for**: CLI `load pack by tftp` command

### 2.6 SFTP Channel
- **Function**: `HW_SWM_CHNL_SFTP_Download` @ `0x0001d344` (1020 bytes)
- **Command**: `psftp get "%s" %s "%s" %s;echo $?>/var/swmresult.txt`
- **Used for**: Secure file transfer via CLI

### 2.7 OAM/DPOE Channel
- **Function**: `HW_SWM_CHNL_OAM_Download` @ `0x0001eb34` (236 bytes)
- **Function**: `HW_SWM_CHNL_OAMCTC21_Download` @ `0x0001ec20` (236 bytes)
- **Used for**: EPON OAM-based upgrades (CTC 2.1 standard)
- **DPOE**: `DPOE_SWM_RPC_GetFirmwareFilename`, `DPOE_SWM_RPC_SetFirmwareFilename`

---

## 3. Update Flow (Receive → Verify → Write → Activate)

### 3.1 Initialization
```
HW_SWM_DllInit @ 0x00028758 (1188 bytes)
  ├── HW_SWM_DevInit       → Flash device initialization
  ├── HW_SWM_EventInit     → Event/message handlers
  ├── HW_SWM_ChnlInit      → Register all 7 download channels
  ├── HW_SWM_COMBIN_Init   → Combined image support
  ├── HW_SWM_SEGMENT_Init  → Segmented download support
  └── HW_SWM_InitPartition → MTD partition mapping
```

### 3.2 Receive Thread
```
HW_SWM_ReceiveThread @ 0x0003b6a8 (748 bytes)
  ├── Opens FIFO: /var/swm_receive_fifo
  ├── Calls HW_SWM_ChnlDownload(channel_type, params, output)
  ├── Monitors download progress with timeouts (AccTimeOut, IntervTimeOut)
  ├── Writes result to /var/swmresult.txt
  └── Reports: "Received %u Bytes"
```

### 3.3 Load Thread (Verification & Flash Write)
```
HW_SWM_LoadThread @ 0x0002c3d8 (316 bytes)
  ├── SWM_LoadPacketInit        → Initialize packet state machine
  ├── SWM_LoadPacketFsm         → Main FSM (520 bytes, drives entire load process)
  │   ├── SWM_LoadPacketHeadInfo    → Parse firmware header
  │   ├── SWM_LoadExtendHeadInfo    → Parse extended header
  │   ├── SWM_LoadPacketItemInfo    → Parse item table (kernel, rootfs, sdk, etc.)
  │   ├── SWM_LoadPacketItemData    → Write items to flash
  │   ├── SWM_LoadFlashCfg          → Load flash configuration
  │   ├── SWM_LoadPacketSDK         → Handle SDK partition
  │   └── SWM_LoadPacketUboot       → Handle U-Boot partition
  ├── SWM_LoadPacketProgress    → Report progress percentage
  └── SWM_LoadPacketExit        → Cleanup
```

### 3.4 Version Comparison
```
HW_SWM_ISUpGrade @ 0x0002fcd4 (340 bytes)
  ├── Gets running version: HW_SWM_GetRunSoftwareVersion
  ├── Gets target version from firmware header
  ├── Calls HW_SWM_LoadVerProc (748 bytes) for version logic
  └── Determines: upgrade, downgrade, or same version
      └── Same version flag: /var/upgrade_same
```

---

## 4. Pre-Flash Validation (UpgradeCheck.xml)

**Function**: `SWM_UpgradeCheckXmlProc` @ `0x0001c7f8` (528 bytes)

The firmware contains `/etc/wap/UpgradeCheck.xml` (copied to `/var/UpgradeCheck.xml` at runtime) which defines hardware compatibility checks. Each check must pass for the upgrade to proceed:

| Check | Purpose | Allowed Values |
|-------|---------|----------------|
| `HardVerCheck` | Board ID validation | 13351, 13371, 13011, 13021, 13691, 13701, 126, 131261, 64, 66, 82, 89, etc. |
| `LswChipCheck` | LAN switch chip | COMMON, NONE, HWSOC3_2, HWSOC6, HWSOC7 |
| `WifiChipCheck` | WiFi chipset | COMMON, AUTOFEM, HWWIFI1_1, HWWIFI1_2, HWWIFI_11521 |
| `VoiceChipCheck` | VoIP chip | COMMON, PEF31001_1_3, PEF31002_1_3 |
| `UsbChipCheck` | USB controller | COMMON, NONE |
| `OpticalCheck` | Optical transceiver | COMMON, NONE, BOB-PHY-13000, BOB-PHY-14000 |
| `OtherChipCheck` | Flash/memory chip | FLASH256, S34ML02G2, W29N02GV, MX30LF2G18AC, etc. |
| `ProductCheck` | Product ID (hex) | 159D, 15ED, 15DD, 26AD, 2C1D, 2E1D, 31FD, 2D7D |
| `ProgramCheck` | Program variant | E8C, COMMON, CHINA, CMCC, CHOOSE, DT_HUNGARY |
| `CfgCheck` | Config compatibility | COMMON, NONE |

**Functions involved in validation**:
- `HW_SWM_CheckUpgradeItem` @ `0x0001c5b0` (584 bytes) - Single item check
- `HW_SWM_CheckUpgradeItemList` @ `0x0001c1bc` (244 bytes) - List iteration
- `HW_SWM_CheckUpgradeAllItemList` @ `0x0001c34c` (180 bytes) - All items
- `SWM_IsUpgradeForbiddenByPdtId` - Product ID block check
- `SWM_IsUpgradeForbiddenByMACInfo` - MAC address block check

---

## 5. Signature & Integrity Verification

### 5.1 CMS Signature Check
```
SWM_CheckSignInfo @ 0x00044ba8 (372 bytes)
  ├── Allocates 0x5000 byte buffer for signature data
  ├── SWM_SIG_CmsCheckSet → Configure CMS parameters
  ├── SWM_Sig_CmsCheckEx  → Perform CMS verification
  └── Reports: "Check the cms sign success!" or "Check the cms sign failed!"
```

### 5.2 RSA Signature Check
```
HW_SWM_CheckBufRsaValid → RSA buffer validation
SWM_RootCheckPdtCert    → Product certificate root check
SWM_RootCheckPdtCore    → Core certificate validation
Reports: "Check the rsa sign success!" or "Check the rsa sign failed!"
```

### 5.3 Hash Verification
```
SWM_Sig_CheckAllItemHash      → Hash all firmware items
SWM_Sig_CheckHashByType       → Per-type hash check
SWM_Sig_CheckPdtListHash      → Product list hash
SWM_CheckItemHash             → Individual item hash
SWM_SelfCheckHashLsit         → Self-integrity hash list
HW_SWM_EfuseSigCheckCore      → eFuse-based signature (hardware root of trust)
```

### 5.4 L2Boot Verification
```
SWM_CheckL2BootVaild          → L2 bootloader integrity
SWM_CheckL2BootInner          → Inner L2 boot check
SWM_CheckL2bootPdtCert        → L2 boot product certificate
```

### 5.5 Product Certificate Chain
```
SWM_EfuseCheckPdtCert         → eFuse-anchored certificate
HW_SWM_GetSigCheckFlag        → Get signature check mode
SWM_Sig_CheckVerionRevokeMask → Version revocation check (anti-rollback)
```

---

## 6. Flash Partition Management

### 6.1 Dual-Bank (A/B) Scheme
The ONT uses an A/B partition scheme for reliable updates:

```
/mnt/jffs2/AArea  → Bank A status
/mnt/jffs2/BArea  → Bank B status

HW_SWM_CheckMasterAndSlaveState @ 0x0001ef4c (480 bytes)
  ├── GetMainAreaSoftwareVersion
  ├── GetSlaveAreaSoftwareVersion
  └── Determines active/standby partitions
```

### 6.2 Flash Operations
```
HW_SWM_DEV_FLASH_Write  @ 0x0002545c (540 bytes) → Write with encryption support
HW_SWM_DEV_FLASH_Read   @ 0x0002410c (344 bytes) → Read with decryption
HW_SWM_FlashCopy        @ 0x00021530 (760 bytes) → Partition copy (A↔B)
HW_SWM_EncryptFlashWrite                          → AES-encrypted flash write
HW_SWM_DecryptFlashRead                           → Decrypted flash read
```

### 6.3 Key Paths
```
/dev/mtd0              → First MTD partition
/dev/mtd%u             → Dynamic MTD selection
/sys/class/ubi/ubi%u/mtd_num → UBI-MTD mapping
/proc/mtd              → Partition table
/var/hw_flashcfg.xml   → Flash configuration
/opt/upt/apps/mtd.booting → Boot partition marker
```

---

## 7. OMCI Software Image (ME Class 7)

The OMCI module (`libomci_smp.so`) implements the ITU-T G.988 Software Image ME:

### 7.1 Download Process
```
OMCI_UPD_StartDownloadProc  @ 0x0000fdec (1112 bytes)
  ├── Validates image size: OMCI_API_CheckImageSize
  ├── Initializes download: OMCI_API_StartDownloadInit (1136 bytes)
  ├── State check: OMCI_StartDownloadStateCheck
  └── Sets upgrade status: OMCI_API_SetOntUpgradeStatus

OMCI_UPD_DownloadSectionProc @ 0x0000e128 (576 bytes)
  └── Receives image data in sections from OLT

OMCI_UPD_EndDownloadProc @ 0x00010840 (1612 bytes)
  ├── Verifies CRC: OMCI_API_GetImageCrc / SaveImageCrc
  ├── Sets version: OMCI_RPC_SetSoftwareVersion (852 bytes)
  ├── Flags: "Enddownload Finished!Update version!"
  └── Writes to: /mnt/jffs2/enddownload
```

### 7.2 Activation & Commit
```
OMCI_UPD_ActiveImageProc    @ 0x000115d4 (164 bytes) → Quick activation
OMCI_UPD_ActiveImageProc_Ex @ 0x00011078 (1372 bytes) → Extended activation
OMCI_UPD_CommitImageProc    @ 0x0000f5e8 (384 bytes)  → Commit (make permanent)
OMCI_UPD_DelActivateFlag    @ 0x0000f7c0 (188 bytes)  → Cleanup
```

### 7.3 Version Reporting
```
OMCI_API_GetSysMainVersion    → Running firmware version
OMCI_API_GetSysStandbyVersion → Standby bank version
OMCI_API_GetOMCIVersion       → OMCI protocol version
OMCI_DM_GetUISoftwareVersion  → UI-friendly version string
```

---

## 8. Feature Flags Controlling Updates

| Feature Flag | Purpose |
|-------------|---------|
| `FT_USB_AUTO_UPGRADE` | Enable USB stick auto-upgrade at boot |
| `FT_HGW_UPGRADE_AP` | Home Gateway AP upgrade support |
| `FT_UPGRADE_DELAY_REBOOT` | Delay reboot after upgrade (e.g., wait for voice calls to end) |
| `FT_K662C_UPGRADE_LIMIT` | K662c-specific MTD layout upgrade restriction |
| `FT_FACTORY_DOWNGRADE_LIMIT` | Block downgrade below factory version |
| `FT_SSMP_AIS_DOWNGRADE_CHECK` | AIS operator downgrade prevention |
| `FT_CWMP_OPTION43_URL_CONTROL` | DHCP Option 43 ACS URL control |

---

## 9. Anti-Rollback / Downgrade Protection

Multiple mechanisms prevent unauthorized firmware downgrades:

1. **Version Revocation Mask**: `SWM_Sig_CheckVerionRevokeMask` - eFuse bits permanently block old versions
2. **Factory Version Lock**: `SWM_PDT_UpgradeCheckForFactoryVersion` / `SWM_PDT_IsNeedLimitFactoryVersion`
3. **K662C Limit**: "K662c has changed mtd, limit downgrade!"
4. **Operator-specific**: `HW_SWM_PDT_UpgradeForAIS`, `SWM_PDT_UpgradeForViettel`, `HW_SWM_PDT_UpgradeCheckForV5`
5. **PBKDF2 Encryption Mode**: `HW_SWM_PDT_UpgradeForPBKDF2Forbid` - blocks incompatible encryption modes

---

## 10. Update State Files

| Path | Purpose |
|------|---------|
| `/mnt/jffs2/commitupgrade` | Upgrade committed flag |
| `/mnt/jffs2/rebootupgrade` | Reboot-after-upgrade flag |
| `/mnt/jffs2/enddownload` | Download completed flag |
| `/mnt/jffs2/Updateflag` | General update flag |
| `/tmp/upgradeflag` | Temporary upgrade indicator |
| `/var/UpgradeSWVersion` | Target software version |
| `/var/upgrade_same` | Same-version upgrade flag |
| `/var/upgrade_no_fail` | No-fail upgrade mode |
| `/var/apupgrade_flag` | AP upgrade in progress |
| `/var/firmware1.tar.gz` | Downloaded firmware package |
| `/mnt/jffs2/main_version` | Persisted main version |
| `/mnt/jffs2/hard_version` | Persisted hardware version |
| `/mnt/jffs2/swm_debug` | SWM debug mode enable |
| `/var/swm_receive_fifo` | IPC FIFO for receive thread |
| `/var/swmresult.txt` | Download result (exit code) |

---

## 11. Capstone Disassembly Summary

### Key Observations from ARM Disassembly

1. **All binaries are ARM 32-bit mode** (not THUMB), compiled with stack canaries (stack protector):
   - Every function loads a canary from GOT, stores to stack frame, and validates before return
   - Functions use `eors r2, r3, r2` + `beq` pattern for canary check

2. **Channel dispatch uses function pointer table**:
   - `HW_SWM_ChnlDownload` loads channel struct, checks for NULL handler at `[r3, #4]`, then calls `blx r3`
   - Each channel registers its download/upload function pair during init

3. **OMCI download is RPC-based**:
   - `HW_SWM_CHNL_OMCI_Download` calls `HW_SWM_OAM_OMCI_RPCCall` for OLT communication
   - Uses message passing (0x20 byte message blocks) via `HW_OS_MsgQSend`

4. **HTTP/HTTPC downloads shell out**:
   - FTP: `ftpput %s %s %s`
   - TFTP: `tftp -i -l "%s" -r %s -g "%s";echo $?>/var/swmresult.txt`
   - SFTP: `psftp get "%s" %s "%s" %s;echo $?>/var/swmresult.txt`
   - HTTPC: `httpc -g -D -i -l %s` (with optional `-s` for HTTPS)

5. **Flash encryption**: Device supports eFuse-based flash encryption:
   - `DM_FlashWriteEncryptCommonWithHead`, `DM_FlashReadDecryptCommon`
   - `HW_SWM_GenerateEncryptFlashHead` creates encryption headers
   - Key derivation involves eFuse hardware and `DM_ReadKeyFromFlashHead`

---

## 12. Conclusion

The EG8145V5 firmware update system is a **passive, multi-channel, push-based architecture**:

- **The ONT never polls for updates** - all updates are initiated externally
- **Primary channel**: OMCI via GPON OLT (operator-controlled, ME class 7)
- **Secondary channel**: TR-069/CWMP via ACS server (operator management platform)
- **Manual channels**: HTTP (web UI), FTP/TFTP/SFTP (CLI commands)
- **USB auto-upgrade**: Controlled by `FT_USB_AUTO_UPGRADE` feature flag
- **Security**: CMS signatures, RSA verification, SHA hash lists, eFuse root of trust, anti-rollback protection
- **Reliability**: Dual-bank A/B partition scheme with automatic fallback
