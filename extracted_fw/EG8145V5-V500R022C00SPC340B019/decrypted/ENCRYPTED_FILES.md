# Encrypted Files in Firmware

These files use Huawei's custom AES-256-CBC encryption (mbedtls_aescrypt2).
The encryption key is generated at runtime by the KMC (Key Management Center)
and stored at `/var/aes_encrypt_1`. It is NOT hardcoded in the firmware.

## File Format

```
[4 bytes: version = 0x00000001 (AES-CBC) or 0x00000004 (variant)]
[4 bytes: CRC32 of original plaintext]
[standard mbedtls_aescrypt2 format]:
  [8 bytes: original filesize (LE u64)]
  [16 bytes: IV (random)]
  [N*16 bytes: AES-256-CBC encrypted data (may contain gzip compressed XML)]
  [32 bytes: HMAC-SHA256 digest]
```

## Key Derivation (mbedtls_aescrypt2 standard, 8192 iterations confirmed)

```python
import hashlib
from Crypto.Cipher import AES

password = open('/var/aes_encrypt_1', 'rb').read()  # from running device

# Key derivation
digest = hashlib.sha256(password).digest()
for _ in range(8192):
    digest = hashlib.sha256(digest + IV).digest()
key = digest  # 32 bytes = AES-256

# HMAC key derivation
for _ in range(8192):
    digest = hashlib.sha256(digest).digest()
hmac_key = digest

# Decrypt
cipher = AES.new(key, AES.MODE_CBC, IV)
plaintext = cipher.decrypt(encrypted_data)
```

## Firmware Configuration

| Setting | Value | Effect |
|---------|-------|--------|
| `FT_SSMP_CTREE_ENCRYPT_KEY` | disabled (enable="0") | No custom key feature |
| `SSMP_SPEC_CONFIG_ENCRYPTION_KEY` | "" (empty) | No ISP-specific key |
| `SPEC_KEY_COMPUTE_RANDOM_TIMES` | 0 | No random iterations |

## Encrypted Files List

| File | Size | Version | Description |
|------|------|---------|-------------|
| `etc/wap/hw_ctree.xml` | 19,128 B | 0x01 | Main configuration tree (user/network settings) |
| `etc/wap/hw_default_ctree.xml` | 19,128 B | 0x01 | Factory default configuration (identical to hw_ctree.xml) |
| `etc/wap/hw_diag_cli.xml` | 16,248 B | 0x01 | Diagnostic CLI commands |
| `etc/wap/hw_shell_cli.xml` | 936 B | 0x01 | Shell CLI command definitions |
| `etc/wap/HighTemperatureConfig.xml` | 1,672 B | 0x01 | Temperature threshold config |
| `etc/wap/spec/encrypt_spec/encrypt_spec.tar.gz` | 4,456 B | 0x01 | Encrypted ISP specifications |
| `etc/wap/spec/encrypt_spec_key/encrypt_spec_key.tar.gz` | 2,152 B | 0x01 | Encrypted specification keys |
| `etc/ont/sdk/HN5176_par.bin` | 1,052 B | 0x01 | SDK parameter file |
| `ttree_spec_smooth.bin` (mtd6) | 8,712 B | 0x04 | TTree upgrade smoothing data |

## How to Decrypt

To decrypt these files, you need the key from a running device:

### Method 1: CLI Backup
```
WAP> backup cfg by sftp svrip <your_ip> remotefile <filename> user <u> pwd <p>
```
This exports the **decrypted** configuration.

### Method 2: SSH Key Extraction
1. Generate SSH host key: `WAP> make ssh hostkey type rsa bits 2048`
2. Install your public key: `WAP> load ssh-pubkey by tftp svrip <ip> remotefile <pubkey>`
3. SSH in and read: `cat /var/aes_encrypt_1`

### Method 3: Use the key with this script
```python
# After obtaining the key, run:
python3 -c "
import hashlib, sys, struct, gzip
from Crypto.Cipher import AES

password = sys.argv[1].encode()
data = open(sys.argv[2], 'rb').read()

# Skip 8-byte Huawei header
aes_data = data[8:]
iv = aes_data[8:24]
encrypted = aes_data[24:-32]

digest = hashlib.sha256(password).digest()
for _ in range(8192):
    digest = hashlib.sha256(digest + iv).digest()

cipher = AES.new(digest, AES.MODE_CBC, iv)
dec = cipher.decrypt(encrypted)

# Try gzip decompression
try:
    result = gzip.decompress(dec)
    open(sys.argv[3], 'wb').write(result)
except:
    # Strip PKCS7 padding
    pad = dec[-1]
    if 0 < pad <= 16:
        dec = dec[:-pad]
    open(sys.argv[3], 'wb').write(dec)
" <password> <encrypted_file> <output_file>
```
