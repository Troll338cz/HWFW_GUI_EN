# ttree_spec_smooth

This is a **Huawei AES-CBC encrypted ttree_spec_smooth** configuration file (Task Tree specification for smooth upgrades).

## Format Analysis

- **Size**: 8,712 bytes (120 bytes header + 8,592 bytes encrypted payload)
- **Version**: 4 (offset 0x00)
- **Mode**: 1 (offset 0x04) — AES-CBC encryption mode indicator
- **Date**: 2022-04-03 (offset 0x28, stored as BCD 0x20220403)
- **Original plaintext size**: 8,585 bytes (offset 0x2C)
- **Padded/encrypted size**: 8,592 bytes (offset 0x30) = 537 × 16-byte AES blocks

## Header Structure (120 bytes / 0x78)

```
Offset  Size  Description
0x00    4     Version (4)
0x04    4     Encryption mode (1 = AES-CBC)
0x08    32    HMAC-SHA256 or integrity hash
0x28    4     Date in BCD format (20220403 = 2022-Apr-03)
0x2C    2     Original plaintext size (8585 bytes)
0x2E    2     Reserved (0)
0x30    4     Encrypted payload size (8592 bytes)
0x34    4     Flags (0x01010101)
0x38    32    Secondary hash / HMAC (possibly IV-derived)
0x58    32    Reserved (zeros)
0x78    var   AES-CBC encrypted payload data
```

## Encryption Analysis

The encrypted payload exhibits properties consistent with **AES-CBC mode**:
- Payload is perfectly 16-byte aligned (AES block size)
- Shannon entropy: **7.98 bits/byte** (near maximum 8.0, confirming encryption)
- **537 unique blocks** with zero repeats (rules out ECB mode)
- No detectable patterns in ciphertext

### Expected Plaintext

When decrypted, the payload should contain a **ttree binary** (magic `0xD7C5B6A4`), the same format used by:
- `/etc/wap/hw_ttree.bin` (885,922 bytes — main Task Tree)
- `/etc/app/*/cfg/*_ttree.bin` (per-app Task Trees)

The ttree defines the device's TR-069/TR-181 data model hierarchy for configuration management.

## Key Management

The encryption key is managed by Huawei's **KMC (Key Management Component)**:

| Component | Description |
|-----------|-------------|
| `libhw_ssp_basic.so` | Contains AES encrypt/decrypt functions |
| `kmc_store_A` / `kmc_store_B` | Encrypted key storage files (1024 bytes each) |
| `libhw_smp_init.so` | Handles TTree initialization and AES decrypt calls |

### Relevant Functions (from `libhw_ssp_basic.so`)

```
HW_OS_AESCBCDecrypt          — AES-CBC decryption
HW_OS_AESDecryptWithKey      — Decrypt with explicit key  
HW_AES_GetCBCKey             — Get CBC encryption key from KMC
KMC_GetAESCBCKey             — KMC key retrieval
OS_AescryptDecrypt           — High-level aescrypt decrypt
SSH_AescryptDecryptFile      — File-level aescrypt decrypt
HW_KMC_GetActiveKey          — Get currently active key
HW_KMC_CfgGetKey             — Get key from configuration
FT_SSMP_CTREE_ENCRYPT_KEY    — Feature toggle for ctree encryption
```

### Key Derivation Chain

```
HiSilicon SoC Root Key (hardware-fused)
    └── KMC Root Key (WSEC_HwLoadRootkey)
        └── KMC Domain Keys (kmc_store_A/B, encrypted)
            └── AES-CBC Working Key (HW_AES_GetCBCKey)
                └── Encrypts/decrypts ttree_spec_smooth payload
```

### Why Decryption is Not Possible Offline

1. The KMC store files (`kmc_store_A/B`) are themselves encrypted by a **root key fused into the HiSilicon SoC**
2. The `WSEC_HwLoadRootkey` function accesses hardware-specific key material
3. Without physical access to the running device's memory or SoC key registers, the encryption key cannot be recovered
4. The file path on the device is `/mnt/jffs2/ttree_spec_smooth` (extracted from `libhw_smp_init.so` strings)

## Related Files

- `/mnt/jffs2/ttree_def_smooth/` — Directory for smooth upgrade ttree definitions
- `/etc/wap/hw_ttree.bin` — Main device Task Tree (unencrypted, magic `0xD7C5B6A4`)
- `/var/aes_encrypt_1` — AES encryption flag file
- `/var/new_key_encryte_ctree` — Key rotation indicator
