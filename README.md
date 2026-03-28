<p align="center">
  <img src="zeroclaw/icon.png" alt="ZeroClaw" width="96" />
</p>

<h1 align="center">ZeroClaw Add-ons for Home Assistant</h1>

<p align="center">
  <a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Ftonyputi%2Fhassio-addons">
    <img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" alt="Add to Home Assistant" />
  </a>
  &nbsp;
  <img src="https://img.shields.io/badge/ZeroClaw-v0.6.5-blue" />
  &nbsp;
  <img src="https://img.shields.io/badge/Raspberry%20Pi-supported-brightgreen" />
  &nbsp;
  <img src="https://img.shields.io/badge/amd64-supported-brightgreen" />
</p>

<p align="center">
  Official community add-ons to run <a href="https://www.zeroclawlabs.ai"><strong>ZeroClaw</strong></a> on Home Assistant.<br/>
  A lightweight AI daemon with persistent memory, scheduling, tools, and messaging integrations.
</p>

---

## Add-ons

### ZeroClaw

Run ZeroClaw as a supervised Home Assistant add-on. Pre-built binaries are downloaded at install time — no compilation, no waiting, no build failures.

**Works on Raspberry Pi (aarch64) and standard x86_64 machines.**

#### Features

- **No compilation** — installs in under 30 seconds on any supported device
- **Multiple AI providers** — Gemini, OpenAI, Anthropic, Mistral, Groq, DeepSeek, and more
- **Persistent memory and workspace** — data survives restarts and updates
- **Telegram integration** — chat with your AI directly from your phone
- **Cron scheduling** — automate tasks with timezone-aware scheduling
- **Web terminal** — browser-based terminal via Home Assistant ingress for advanced configuration
- **S6-overlay supervision** — automatic process restart on failure

[Documentation](zeroclaw/DOCS.md) · [Changelog](zeroclaw/CHANGELOG.md) · [ZeroClaw website](https://www.zeroclawlabs.ai)

---

## Installation

### One-click

<a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Ftonyputi%2Fhassio-addons">
  <img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" />
</a>

### Manual

1. In Home Assistant go to **Settings → Add-ons → Add-on Store**
2. Click **⋮ → Repositories** and add: `https://github.com/tonyputi/hassio-addons`
3. Find **ZeroClaw** in the store → **Install**
4. Set your **provider** and **API key** in the Configuration tab
5. Click **Start**

### Minimal configuration

| Option | Required | Description |
| ------ | :------: | ----------- |
| `provider` | ✓ | AI provider (Gemini, OpenAI, Anthropic, …) |
| `api_key` | ✓ | API key for the chosen provider |
| `model` | ✓ | Model to use (e.g. `gemini-2.0-flash`, `gpt-4o`) |
| `timezone` | ✓ | IANA timezone for cron jobs (e.g. `Europe/Rome`) |
| `telegram_token` | | Telegram bot token — create one via [@BotFather](https://t.me/BotFather) |
| `telegram_allowed_users` | | Comma-separated user IDs/usernames, or `*` for everyone |

Persistent data lives at `/data/zeroclaw/`. Use the **Web terminal** (ZeroClaw Terminal tab) for advanced configuration such as additional providers, channels, or workspace customization.

---

## Why not the existing community add-on?

| | [SeoFood/hassio-addons-zeroclaw](https://github.com/SeoFood/hassio-addons-zeroclaw) | This add-on |
| -- | :---: | :---: |
| Install time on Raspberry Pi | ~20 min | ~30 sec |
| Compiles from Rust source | yes | no |
| ZeroClaw version | 0.1.x | 0.6.5 |
| Base image | Debian | Debian |
| Telegram configuration | manual | built-in |
| Web terminal | no | yes |
| S6-overlay supervision | no | yes |

---

## Support

- ZeroClaw documentation: [zeroclawlabs.ai](https://www.zeroclawlabs.ai)
- Issues with this add-on: [open an issue](https://github.com/tonyputi/hassio-addons/issues)
