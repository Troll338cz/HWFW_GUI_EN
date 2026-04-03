# EG8145V5 Firmware Deep Analysis Report
## Firmware: V500R022C00SPC340B019 | ARM 32-bit | Capstone 5.0.7 | QEMU 8.2.2

---

## 1. Archivos Extraídos del Firmware

| Partición | Archivo | Tipo | Tamaño |
|-----------|---------|------|--------|
| mtd0 | UpgradeCheck.xml | ASCII XML | 2.6 KB |
| mtd1 | signinfo_payload.bin | Signature data | 16 KB |
| mtd2 | uboot_payload.bin | U-Boot bootloader | 503 KB |
| mtd3 | kernel_payload.bin | Linux ARM zImage | 2.1 MB |
| mtd4 | rootfs_payload.bin | SquashFS (lzma) | 38 MB |
| mtd7 | setequiptestmodeoff.sh | Shell script | 791 B |
| mtd8 | dealcplgin.sh | Shell script | 244 B |
| mtd9 | preload_cplugin.tar.gz | Plugin package | 2.0 MB |
| mtd10 | sdkfs_squashfs.bin | SquashFS SDK | 98 KB |
| mtd11 | plugin_timestamp.txt | ASCII text | 28 B |

---

## 2. Credenciales Extraídas

### 2.1 Sistema de Usuarios (etc/wap/passwd)

| Usuario | UID | GID | Descripción | Shell |
|---------|-----|-----|-------------|-------|
| root | 0 | 0 | root | /sbin/nologin |
| srv_amp | 3003 | 2002 | hw_srv_amp | /bin/false |
| srv_web | 3004 | 2002 | hw_srv_web | /bin/false |
| osgi_proxy | 3005 | 2000 | hw_osgi_proxy | /bin/false |
| srv_igmp | 3006 | 2002 | hw_srv_igmp | /bin/false |
| cfg_cwmp | 3007 | 2001 | hw_cfg_cwmp (TR-069) | /bin/false |
| srv_ssmp | 3008 | 2002 | hw_srv_ssmp | /bin/false |
| cfg_cli | 3010 | 2001 | hw_cfg_cli | /bin/false |
| srv_bbsp | 3012 | 2002 | hw_srv_bbsp | /bin/false |
| srv_dbus | 3014 | 2002 | hw_srv_dbus | /bin/false |
| srv_clid | 3030 | 2002 | hw_srv_clid (CLI daemon) | /bin/false |
| srv_voice | 4002 | 2002 | VoIP service | /bin/false |
| srv_kmc | 3020 | 500 | Key Management Center | /bin/false |
| nobody | 65534 | 65534 | nobody | /bin/false |

**Nota**: Todos los usuarios tienen shell `/bin/false` o `/sbin/nologin`. root no tiene password hash (*).

### 2.2 Credenciales en kernelapp.config (MyPlugin)

```json
{
  "AppString": "abc###78d!",
  "local_restssl_key": "sovolTuHdX5WHp89NbCwf2lMIc5miO60P2ab/rSw1POkdlHrQ36e19x95r4Bje8e",
  "USER_AGENT_SHA512": "744555eaf671298787a3e5c30577be22"
}
```

### 2.3 Credenciales en restssl_info.config

```json
{
  "restssl_key": "$22L;NS]5GTU=}:AUAXKcW'g`hLd^yv1^[V6IjAXA*-S*-\"Uo\\A8Be<B!MHdp@$",
  "old_restssl_key": "$2*fR[YH14,Q<Q8SOgV<I%<:1b5!X(:Dod<e(TD!e<$"
}
```

### 2.4 Credenciales en init_local.json

```json
{
  "INIT_LOAD": "489BFA9B63C42101B583A7A5625FB4AF",
  "INIT_CONVERT": "IY4EA+2v3dvaI7qYDbk+HZsZUu/QuxdquYFzsCoaMP7gi3926jDAPvLPwpYyovQkQi/sJp5vcAQA0QY8VdtI9g=="
}
```

### 2.5 hw_boardinfo (Información de Hardware)

| ID | Valor | Descripción |
|----|-------|-------------|
| 0x01 | 1 | Board type |
| 0x02 | 6877687700000001 | Board ID ("hwhw" + version) |
| 0x05 | 123 | Hardware version |
| 0x0a | 00:00:5E:00:53:02 | MAC base (placeholder/IANA) |
| 0x1a | COMMON | LAN switch type |
| 0x1b | COMMON | WiFi chip type |

### 2.6 Configuración ISP Telmex (spec_telmex.cfg)

```
SSMP_SPEC_CLI_USERGRP = 0x80004000
SSMP_SPEC_CLI_USER_CFG = "inst1:UserGroup=0x83005000:AccessInterface="
                          "inst2:UserGroup=0x83005000:AccessInterface=OLT_TELNET"
SSMP_SPEC_WEB_PWDENCRYPT = 3  (SHA-256 mode)
SSMP_SPEC_WEB_PORTNUM = 80
SSMP_SPEC_WEB_OUTPORTNUM = 8090
```

### 2.7 Páginas Sin Autenticación (SSMP_SPEC_WEB_NO_AUTH_PAGE)

```
md5.js, RndSecurityFormat.js, mm.cgi, ssmpdes.js, jquery.min.js,
httpsdirect.asp, GetRandCount.asp, getRandString.asp, safelogin.js,
updatePopWindow.asp, urlPopWindow.asp, updateConfig.asp,
agreePopUpgrade.cgi, refusePopUpgrade.cgi, remindPopUpgrade.cgi,
updateNote.asp, ajaxconfig.js, getajax.cgi, marketRedirect.asp,
WEB_WindowsPopTracerSet, WebWdPopCancel, access.asp
```

---

## 3. Cifrado del hw_ctree.xml

### 3.1 Formato del Archivo

```
[4 bytes: version = 0x00000001 (AES-CBC)]
[16 bytes: IV (generado aleatoriamente)]
[N bytes: AES-256-CBC(gzip(XML))]
[32 bytes: HMAC-SHA256]
```

Formato mbedtls_aescrypt2: `[8:filesize][16:IV][encrypted_blocks][32:HMAC]`

### 3.2 Flujo de Cifrado/Descifrado

```
Escritura: XML → gzip compress → AES-256-CBC encrypt → escribir archivo
Lectura:   archivo → AES-256-CBC decrypt → gzip decompress → XML parse
```

### 3.3 Derivación de Clave

| Componente | Función | Ubicación |
|-----------|---------|-----------|
| Lectura de clave | `HW_XML_GetEncryptedKey` | libhw_ssp_basic.so |
| Almacén de clave | `/var/aes_encrypt_1` | Runtime (tmpfs) |
| Guardado | `HW_SWM_SaveEncryptedKeyTOVarFile` | libhw_smp_init.so |
| Derivación | `mbedtls_aescrypt2` (SHA-256 PBKDF x8192) | libpolarssl.so |
| KMC Root Key | `WSEC_HwLoadRootkey` → `CreateRootKey` | libhw_ssp_basic.so |
| KMC Domain | Domain=1, KeyType=2 | KMC ctree encryption domain |

### 3.4 Feature Flags de Cifrado

| Flag | Estado | Efecto |
|------|--------|--------|
| `FT_SSMP_CTREE_ENCRYPT_KEY` | **DISABLED** (enable="0") | Usa clave KMC por defecto |
| `FT_SUPPORT_BOARDINFO_ENCRYPT` | Enabled en HG8145V5v1/EG8145_v5_v1 | Cifra boardinfo |
| `SSMP_SPEC_CONFIG_ENCRYPTION_KEY` | **VACÍO** | Sin clave custom, usa KMC default |

### 3.5 Resultado del Análisis de Descifrado

- **347 librerías .so escaneadas** para buscar clave AES hardcodeada
- **22,033 secuencias de 16 bytes** probadas como clave AES
- **Derivación PBKDF** probada con 25+ contraseñas candidatas
- **Resultado**: La clave AES es generada por el KMC (Key Management Center) en el primer arranque y almacenada en `/mnt/jffs2/`. No está hardcodeada en el firmware estático.
- **Para descifrar**: Se necesita extraer la clave de un dispositivo en funcionamiento (vía acceso CLI/SSH) o emular completamente el proceso de arranque KMC con QEMU.

### 3.6 hw_aes_tree.xml (NO CIFRADO)

Este archivo define la estructura de campos que se cifran **individualmente** dentro del ctree (contraseñas de PPPoE, WiFi, VPN, etc.):

```xml
<InternetGatewayDevice>
  <X_HW_AppRemoteManage>
    <Password/> <PlatPassword/> <CertPassword/>
    <LocalUserPassword/> <LocalAdminPassword/>
  </X_HW_AppRemoteManage>
  <ManagementServer>
    <Password/> <ConnectionRequestPassword/> <STUNPassword/>
    <X_HW_CertPassword/> <SftpPassphraseKey/>
  </ManagementServer>
  <WANDevice><WANConnectionDevice>
    <WANPPPConnection><Password/></WANPPPConnection>
    <WANIPConnection><X_HW_IPoEPassword/></WANIPConnection>
  </WANConnectionDevice></WANDevice>
  <LANDevice><WLANConfiguration>
    <KeyPassphrase/> <PreSharedKey/>
    <WEPKey><WEPKey/></WEPKey>
  </WLANConfiguration></LANDevice>
  <UserInterface>
    <X_HW_WebUserInfo><Password/><FactoryPassword/></X_HW_WebUserInfo>
    <X_HW_CLIUserInfo><Userpassword/></X_HW_CLIUserInfo>
  </UserInterface>
  <!-- + VPN passwords, DDNS, FTP, MQTT, XMPP, certificates, etc. -->
</InternetGatewayDevice>
```

---

## 4. Certificados SSL Extraídos

### 4.1 MyPlugin SSL (preload_cplugin)

| Archivo | Tipo | Uso |
|---------|------|-----|
| `server_ssl.pem` | Certificado servidor | REST API del plugin (puerto 9013) |
| `server_key_ssl.pem` | Clave privada | Clave del servidor REST |
| `trust_ssl.pem` | CA de confianza | Validación de clientes |

### 4.2 Certificados del Sistema

| Archivo | Ubicación |
|---------|-----------|
| `app_cert.crt` | /etc/app_cert.crt |
| `plugpub.crt` | /etc/wap/plugpub.crt |
| `servercert.pem` | /etc/wap/hilinkcert/ |
| `dropbear_rsa_host_key` | /etc/dropbear/ (SSH host key) |

---

## 5. Spec Cifrados (encrypt_spec)

| Archivo | Tamaño | Estado |
|---------|--------|--------|
| `encrypt_spec.tar.gz` | 4,456 bytes | Cifrado (header: 01 00 00 00) |
| `encrypt_spec_key.tar.gz` | 2,152 bytes | Cifrado (header: 01 00 00 00) |

Ambos usan el mismo formato de cifrado que hw_ctree.xml (mbedtls_aescrypt2 con KMC key).

---

## 6. Emulación QEMU

### 6.1 Estado

```
$ qemu-arm-static -L ./rootfs ./rootfs/sbin/busybox.suid --help
BusyBox v1.32.1 () multi-call binary.
✓ Emulación ARM funcional
```

### 6.2 Binarios Emulables

- `busybox.suid` - Shell y utilidades
- `dnsmasq` - Servidor DNS/DHCP
- `ipset` - Gestión de conjuntos IP
- `xtables-legacy-multi` - iptables

### 6.3 Limitaciones

Los servicios del ONT (`srv_ssmp`, `srv_web`, `cfg_cwmp`, etc.) dependen de:
- Hardware HiSilicon SDK (módulos kernel `hi_*.ko`)
- D-Bus IPC entre procesos
- KMC para gestión de claves
- Flash MTD para lectura/escritura

---

## 7. Proxy y Conexiones Externas

### 7.1 Configuración de Proxy

No se encontraron credenciales de proxy hardcodeadas. El soporte de proxy existe en:

```
# libhw_smp_httpclient.so
Proxy-Authorization: Basic <base64>
Proxy-Authorization: Digest username="%s", realm="%s"
PROXY-Authenticate
HW_HTTP_ClientSetProxy  @ 0x000093e0 (156 bytes)
```

El proxy se configura dinámicamente via TR-069 o web UI, no está hardcodeado.

### 7.2 Servidores Externos Referenciados

Solo se encontraron URLs con templates dinámicos (no hardcodeados):
- `http://%s/updateConfig.asp` - Servidor de actualización (IP dinámica)
- `http://%s/updatePopWindow.asp` - Pop-up de actualización
- `http://192.168.1.1/upgrade.cgi` - Único IP hardcodeado (loopback local)

**No existen URLs de servidores Huawei hardcodeadas en los binarios.**

---

## 8. Archivos tar.gz y Paquetes

### 8.1 preload_cplugin.tar.gz (Extraído)

```
MyPlugin/
├── etc/config/
│   ├── kernelapp.config    ← Credenciales: AppString, restssl_key
│   ├── restssl_info.config ← Claves REST SSL
│   ├── init_local.json     ← Hash INIT_LOAD, INIT_CONVERT
│   ├── opkg.conf           ← Configuración opkg (vacía)
│   ├── server_ssl.pem      ← Certificado SSL del servidor
│   ├── server_key_ssl.pem  ← Clave privada SSL
│   ├── trust_ssl.pem       ← CA de confianza
│   └── useragent_feature.json ← Fingerprinting de dispositivos
└── Lib/
    ├── libmbedcrypto.so     ← mbedTLS crypto
    └── (otras libs)
```

### 8.2 SDK SquashFS (mtd10)

```
sdkfs_squashfs.bin (98 KB, SquashFS v4.0 lzma, 13 inodes)
```

### 8.3 encrypt_spec.tar.gz / encrypt_spec_key.tar.gz

Archivos de especificación cifrados del operador. Contienen configuraciones específicas del ISP que se aplican durante la personalización del firmware. Cifrados con el mismo sistema KMC.

---

## 9. Resumen de Herramientas Creadas

| Herramienta | Archivo | Descripción |
|-------------|---------|-------------|
| ARM Disassembler | `analysis/disasm_arm_binary.py` | Desensamblador ARM con Capstone para análisis de binarios |
| FW Downloader | `analysis/hw_fw_downloader.py` | Descargador de firmware que replica el comportamiento del ONT |
| FW Update Analysis | `analysis/firmware_update_mechanism.md` | Documentación completa del mecanismo de actualización |
| Deep Analysis | `analysis/deep_analysis_report.md` | Este documento |
