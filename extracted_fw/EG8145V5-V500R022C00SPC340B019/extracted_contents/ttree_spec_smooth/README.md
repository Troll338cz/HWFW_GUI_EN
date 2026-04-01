# ttree_spec_smooth

This is a **Huawei signed/encrypted ttree_spec_smooth** configuration file.

## Format Analysis

- **Size**: 8,712 bytes
- **Version**: 4 (offset 0x00)
- **Type**: 1 (offset 0x04)
- **Date**: 2022-04-03 (offset 0x28, stored as 0x20220403)
- **Payload size**: 8,585 bytes (offset 0x2C)
- **Header**: Contains SHA-256 signature/hash (32 bytes at offset 0x08)

## Structure

```
Offset  Size  Description
0x00    4     Version (4)
0x04    4     Type/Flags (1)
0x08    32    SHA-256 hash/signature
0x28    4     Date (BCD: 20220403)
0x2C    2     Payload size (8585)
0x2E    2     Reserved (0)
0x30    8     Flags (01010101 + additional)
0x38    32    Secondary signature
0x58    32    Padding (zeros)
0x78    var   Encrypted payload data
```

This file uses Huawei's proprietary encryption and cannot be decrypted without the vendor's keys. It is used internally by the device's task tree system for firmware upgrade and configuration management.
