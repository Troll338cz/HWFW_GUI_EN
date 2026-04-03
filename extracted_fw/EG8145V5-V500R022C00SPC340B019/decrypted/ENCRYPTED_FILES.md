# Encrypted Files in Firmware

These files use Huawei's custom AES-256-CBC encryption (mbedtls_aescrypt2).
The encryption key is generated at runtime by the KMC (Key Management Center)
and stored at `/var/aes_encrypt_1`. It is NOT hardcoded in the firmware.

## File Format

```
[4 bytes: version = 0x00000001]
[4 bytes: CRC32 of original plaintext]
[8 bytes: original filesize (LE u64)]
[16 bytes: IV (random)]
[N*16 bytes: AES-256-CBC encrypted data (may be gzip compressed XML)]
[32 bytes: HMAC-SHA256 digest]
```

## Key Derivation

```
password = contents of /var/aes_encrypt_1 (max 32 chars)
digest = SHA-256(password)
for i in 0..8191:
    digest = SHA-256(digest || IV)
key = digest (32 bytes = AES-256)
```

## Configuration

- `FT_SSMP_CTREE_ENCRYPT_KEY` = disabled (enable="0")
- `SSMP_SPEC_CONFIG_ENCRYPTION_KEY` = "" (empty)
- `SPEC_KEY_COMPUTE_RANDOM_TIMES` = 0

## Encrypted Files

| File | Size | Header |
|------|------|--------|
| `etc/wap/hw_default_ctree.xml` | 19128 bytes | 01000000066e2177 |
| `etc/wap/hw_diag_cli.xml` | 16248 bytes | 010000007be8c01e |
| `etc/wap/HighTemperatureConfig.xml` | 1672 bytes | 0100000075825d8e |
| `etc/wap/hw_ctree.xml` | 19128 bytes | 01000000066e2177 |
| `etc/wap/hw_shell_cli.xml` | 936 bytes | 01000000c39fa3f3 |
| `etc/wap/spec/encrypt_spec/encrypt_spec.tar.gz` | 4456 bytes | 0100000064836516 |
| `etc/wap/spec/encrypt_spec_key/encrypt_spec_key.tar.gz` | 2152 bytes | 01000000275e57d5 |

## How to Decrypt

To decrypt these files, you need the key from a running device:

1. Access the CLI (`WAP>` prompt)
2. Use `backup cfg by sftp svrip <ip> remotefile <file>` to export config
3. Or extract `/var/aes_encrypt_1` via SSH access
4. Use the key with the mbedtls_aescrypt2 algorithm above
