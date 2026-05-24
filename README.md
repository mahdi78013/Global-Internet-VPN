# اینترنت آزاد³⁶⁹

[![GitHub](https://img.shields.io/badge/GitHub-اینترنت_آزاد³⁶⁹-blue?logo=github)](https://github.com/mahdi78013/Global-Internet-VPN)

>**Youtube safe search** and **live streaming** are now **Bypassed & Working** by default. so you don't need `youtube_via_relay` or Cloudflare / VPS `exit_node` for it.


**Language:** English | [Persian / فارسی](README_FA.md)

**Telegram Channel 📣:** [https://t.me/muntivpn](https://t.me/muntivpn) | @muntivpn

**Telegram Group 📣:** [https://t.me/+gklMAfodGdE3MGRk](https://t.me/+gklMAfodGdE3MGRk)


اینترنت آزاد³⁶⁹ is a local proxy that routes browser traffic through a Google Apps Script relay using domain fronting. The simple path needs only this project and a free Google account. For sites that block Google egress, you can optionally add an exit node later.

We mainly use MITM (Man in the Middle) and Domain Fronting techniques.

```text
Browser -> Local proxy -> Google front -> Your Apps Script relay -> Target site
                         network filter sees a Google-facing connection
```

## Quick Menu 🧭

Click the links below for guides on common topics.

[Getting Started](docs/GETTING_STARTED.md) : How to set up the proxy and deploy the Google relay.

[Exit Node](docs/exit-node/EXIT_NODE_DEPLOYMENT.md) : Connect to Cloudflare Workers or a VPS for destinations to fix ChatGPT, Turnstile, and similar sites blocking Google IPs.

[LAN Sharing](docs/LAN_SHARING.md) : Share the proxy with other devices on your local network. (Android, iOS, other computers)

[Configuration](docs/CONFIGURATION.md) : Reference for all config options, plus diagnostic commands.

[Security](docs/SECURITY.md) : Important notes on safely using and sharing the proxy.

[Troubleshooting](docs/TROUBLESHOOTING.md) : Common issues and how to resolve them.

[Docker](docs/DOCKER.md) : Instructions for running the proxy in a Docker container.

[Architecture](docs/ARCHITECTURE.md) : Overview of the system design and components.

## Fast Start ⚡

Before running the local proxy, deploy the Google relay once. You only need a Google account and about two minutes.

## Deploy The Google Relay ☁️

1. Open [Google Apps Script](https://script.google.com/) and sign in.
2. Click **New project**.
3. Delete the default editor content.
4. Open [apps_script/Code.gs](apps_script/Code.gs), copy everything, and paste it into Apps Script.
5. Find this line and replace it with your own long secret:

    ```javascript
    const AUTH_KEY = "your-secret-password-here";
    ```

6. Click **Deploy** -> **New deployment** -> **Web app**.
7. Set **Execute as** to **Me**.
8. Set **Who has access** to **Anyone**.
9. Click **Deploy**, approve the permission screen, and copy the **Deployment ID**.

Keep these two values ready for the setup wizard:

- `Deployment ID` from Google Apps Script
- `AUTH_KEY`, a long secret that must match `auth_key` in your local config

If you want more detail, use [Getting Started](docs/GETTING_STARTED.md#2-deploy-the-google-relay).

Download the project with either Git or ZIP, then run the one-click launcher.


**Option A: ZIP**

[Click to Download](https://github.com/mahdi78013/Global-Internet-VPN/archive/refs/heads/main.zip)


**Option B: Git**

```bash
git clone https://github.com/mahdi78013/Global-Internet-VPN.git
cd Global-Internet-VPN
```


Then start the app:

**Windows**

```cmd
start.bat
```

**Linux / macOS**

```bash
chmod +x start.sh
./start.sh
```

The launcher creates a virtual environment, installs dependencies, opens the setup wizard if `config.json` is missing, and starts the proxy.

After it starts, configure your browser to use:

| Field | Value |
|-------|-------|
| Proxy type | HTTP |
| Address | `127.0.0.1` |
| Port | `8085` |
| SOCKS5 port | `1080` |

After starting, CA will be installed automatically.

You can use telegram as : https://t.me/socks?server=127.0.0.1&port=1080 or if you are using PC client, you can add HTTP proxy with manually.

## Common Next Steps 🛠️

- If the browser shows certificate warnings, open [Troubleshooting](docs/TROUBLESHOOTING.md#certificate-errors).
- If you see `unauthorized`, make sure `AUTH_KEY` in [apps_script/Code.gs](apps_script/Code.gs) exactly matches `auth_key` in `config.json`.
- If ChatGPT, Turnstile, or similar sites block the Google exit IP, use [Exit Node Guide](docs/exit-node/EXIT_NODE_DEPLOYMENT.md).

## Support And Updates 📣

- Telegram channel: [https://t.me/muntivpn](https://t.me/muntivpn)
- Telegram group: [https://t.me/+gklMAfodGdE3MGRk](https://t.me/+gklMAfodGdE3MGRk)

## Safety 🔒

This project is provided for educational, testing, and research use. You are responsible for following applicable laws and service terms. Never share `config.json`, `auth_key`, `ca/`, or an exit-node URL together with a valid PSK. Read [Security Notes](docs/SECURITY.md) before sharing the proxy with other devices.

## Legal Disclaimer ⚠️

- **Limitation of liability:** Developers and contributors are not responsible for direct, indirect, incidental, consequential, or other damages resulting from use of this project or inability to use it.
- **User responsibility:** Running this project outside controlled environments may affect networks, accounts, proxies, certificates, or connected systems. You are solely responsible for installation, configuration, and usage.
- **Legal compliance:** You are responsible for complying with all applicable local, national, and international laws and regulations before using this software.
- **Google services compliance:** If you use Google Apps Script or other Google services, you are responsible for complying with Google's Terms of Service, acceptable use rules, quotas, and platform policies. Misuse can lead to suspension or termination of accounts or deployments.

## License

MIT
