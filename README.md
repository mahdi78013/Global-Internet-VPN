# 🌐 اینترنت آزاد³⁶⁹

[![GitHub](https://img.shields.io/badge/GitHub-Global--Internet--VPN-blue?logo=github)](https://github.com/mahdi78013/Global-Internet-VPN)
[![Telegram](https://img.shields.io/badge/Telegram-muntivpn-blue?logo=telegram)](https://t.me/muntivpn)

**Language:** English | [فارسی](README_FA.md)

**Telegram Channel 📣:** [https://t.me/muntivpn](https://t.me/muntivpn) | 

**Telegram Group 📣:** [https://t.me/+gklMAfodGdE3MGRk](https://t.me/+gklMAfodGdE3MGRk)

اینترنت آزاد³⁶⁹ is a one-click VPN tool for Windows that bypasses internet filtering using Google Apps Script relay and domain fronting. Just run `Global-Internet.bat` — everything sets up automatically.

```text
Browser -> Local proxy -> Google front -> Your Apps Script relay -> Target site
                         network filter sees a Google-facing connection
```

## Quick Start ⚡

### Step 1 — Deploy Google Relay ☁️

1. Go to [Google Apps Script](https://script.google.com/) and sign in
2. Click **New project** and delete the default content
3. Open `apps_script/Code.gs`, copy everything, and paste it
4. Find this line and replace with your own secret:
   ```javascript
   const AUTH_KEY = "your-secret-password-here";
   ```
5. Click **Deploy** → **New deployment** → **Web app**
6. Set **Execute as** → **Me** and **Who has access** → **Anyone**
7. Click **Deploy** and copy the **Deployment ID**

Keep these two values ready:
- `Deployment ID` from Google Apps Script
- `AUTH_KEY` — must match `auth_key` in your local config

### Step 2 — Download

**Option A: ZIP**

[⬇️ Click to Download](https://github.com/mahdi78013/Global-Internet-VPN/archive/refs/heads/main.zip)

**Option B: Git**

```bash
git clone https://github.com/mahdi78013/Global-Internet-VPN.git
cd Global-Internet-VPN
```

### Step 3 — Run

Double-click `Global-Internet.bat`.

On first run, a setup wizard asks for your Deployment ID and Auth Key once — after that it remembers. The proxy sets automatically and a desktop shortcut is created.

> ⚠️ **Keep this window open** — closing it disconnects the VPN and clears the proxy

## Browser Proxy Settings ⚙️

If not auto-detected, set manually:

| Field | Value |
|-------|-------|
| Proxy type | HTTP |
| Address | `127.0.0.1` |
| Port | `8085` |
| SOCKS5 port | `1080` |

## Requirements 📋

- Windows 10 or 11
- [Python 3.8+](https://www.python.org/downloads/) — check **Add Python to PATH** during install

## Common Issues 🛠️

- **Certificate warnings** → see [Troubleshooting](docs/TROUBLESHOOTING.md)
- **`unauthorized` error** → make sure `AUTH_KEY` in `Code.gs` matches `auth_key` in `config.json`
- **pip install failed** → turn on another VPN temporarily, then re-run

## Support 📣

- Telegram channel: [https://t.me/muntivpn](https://t.me/muntivpn)
- Telegram group: [https://t.me/+gklMAfodGdE3MGRk](https://t.me/+gklMAfodGdE3MGRk)

## Safety 🔒

Never share `config.json`, `auth_key`, or the `ca/` folder. This project is for personal and educational use.

## Credits

This project is an improved version of [MasterHttpRelayVPN](https://github.com/masterking32/MasterHttpRelayVPN) by [masterking32](https://github.com/masterking32). We have made modifications and improvements on top of the original work.

## License

MIT
