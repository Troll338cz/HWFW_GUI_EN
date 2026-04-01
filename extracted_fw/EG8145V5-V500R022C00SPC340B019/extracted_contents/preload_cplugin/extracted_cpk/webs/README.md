# webs.tar.gz — Extracted Web UI Contents

Extracted from `MyPlugin/etc/res/webs.tar.gz` inside `kernelapp.cpk`.

This is Huawei's **mobile web UI** for gateway diagnostics, WiFi optimization, and QR code sharing. It runs on the device's embedded CivetWeb server (port configured in `kernelapp.config`).

## Directory Structure

```
webs/phone/
├── phone.html                          — Main entry: potential problems dashboard
├── diagnose.html                       — Network diagnostics launcher
├── qrcode.html                         — QR code WiFi sharing (China Unicom branded)
│
├── common/                             — Shared libraries
│   ├── jquery.min.js                   — jQuery (minified)
│   ├── qrcode.js                       — QR code generation library
│   ├── xssCheck.js                     — XSS input sanitization (46 lines)
│   └── base.css                        — Base styles
│
├── diagnose/                           — Network diagnostic module
│   ├── html/diagnoseResult.html        — Diagnosis results page
│   ├── js/
│   │   ├── RESOURCE.js                 — i18n strings (Chinese/English)
│   │   ├── diagnose.js                 — Diagnostic logic (161 lines)
│   │   └── diagnoseResult.js           — Result display (84 lines)
│   ├── css/
│   │   ├── diagnose.css                — Diagnostic page styles
│   │   └── diagnoseResult.css          — Result page styles
│   └── image/                          — 12 icons (Internet, router, terminal, progress bars, etc.)
│
├── potentialProblems/                   — WiFi optimization / AP positioning
│   ├── html/
│   │   ├── adjustPosition.html         — WiFi signal strength / AP placement tool
│   │   └── success.html                — Operation success page
│   ├── js/
│   │   ├── RESOURCE.js                 — i18n strings (Chinese/English)
│   │   ├── index.js                    — Problem detection logic (165 lines)
│   │   └── adjustPosition.js           — Signal measurement UI (215 lines)
│   ├── css/
│   │   ├── phone.css                   — Mobile layout styles
│   │   └── adjustPosition.css          — Position adjustment styles
│   └── image/                          — 15 icons (AP, router, signal quality indicators)
│
└── qrCode/                             — QR code WiFi sharing
    ├── js/
    │   ├── RESOURCE.js                 — i18n strings (Chinese/English)
    │   └── qrCodeAction.js             — QR generation logic (75 lines)
    ├── css/
    │   ├── qrCodeCssPc.css             — Desktop layout
    │   └── qrCodeCssPhone.css          — Mobile layout
    └── image/
        ├── qrCodeLOGO.png              — QR code logo overlay
        └── ChinaUnicomLOGO.png         — China Unicom carrier branding
```

## File Inventory

| Category | Count | Description |
|----------|-------|-------------|
| HTML     | 6     | Main pages and sub-pages |
| JavaScript | 11  | App logic + i18n resources |
| CSS      | 7     | Mobile-responsive styles |
| Images   | 29    | PNG icons and graphics |
| **Total** | **53** | |

## Modules

### 1. Network Diagnostics (`diagnose/`)
- **diagnose.html** → One-click network diagnosis
- Tests connectivity: Internet ↔ Gateway ↔ Terminal (STA)
- Shows progress bar during diagnosis
- **diagnoseResult.html** → Displays fault codes with handling suggestions
- Topology visualization: Internet—Router—Terminal with status indicators

### 2. Potential Problems (`potentialProblems/`)
- **phone.html** → Main dashboard showing detected network issues
- Categories: hijack detection, weak RSSI, long online time, interference
- **adjustPosition.html** → WiFi AP positioning tool
- Real-time signal strength measurement with circular gauge
- Shows near/moderate/far range zones with speed recommendations
- **success.html** → Operation confirmation

### 3. QR Code Sharing (`qrCode/`)
- **qrcode.html** → Generates QR code for WiFi credentials
- Displays broadband account info and fault codes
- China Unicom branded (山东联通/Shandong Unicom)
- Uses `qrcode.js` library for client-side QR generation

## Internationalization (i18n)

All modules support **Chinese** and **English** via `RESOURCE.js` files:
- Language detected from `navigator.language`
- Chinese (`zh`) → `rCN` resource object
- English (default) → `rEN` resource object
- Strings loaded via `loadLanguage()` function matching `key` attributes in HTML

## Security

- **xssCheck.js** (46 lines) — Input sanitization for XSS prevention
- All user-facing strings use key-based localization (no raw HTML injection)
- Content served through CivetWeb embedded server with SSL (port 9013/9011)
