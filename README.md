<p align="center">
  <img src="zeroclaw/icon.png" alt="ZeroClaw" width="120" />
</p>

<h1 align="center">ZeroClaw Add-ons for Home Assistant</h1>

<p align="center">
  <a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Ftonyputi%2Fhassio-addons">
    <img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" alt="Add to Home Assistant" />
  </a>
</p>

<p align="center">
  Bring the power of <a href="https://www.zeroclawlabs.ai">ZeroClaw</a> to your Home Assistant instance.<br/>
  A lightweight AI daemon with persistent memory, tools, cron scheduling, and Telegram integration.
</p>

---

## Add-ons

### ![ZeroClaw](https://img.shields.io/badge/ZeroClaw-v0.6.5-blue?logo=rust) &nbsp; ZeroClaw

> AI daemon for your smart home — no cloud required, no compilation, no waiting.

![aarch64](https://img.shields.io/badge/Raspberry%20Pi%20(aarch64)-supported-brightgreen)
![amd64](https://img.shields.io/badge/amd64-supported-brightgreen)

Run ZeroClaw as a managed Home Assistant add-on. The add-on downloads pre-built binaries at install time — no Rust toolchain, no 20-minute compilation. Just install and go.

**What ZeroClaw can do on your Home Assistant device:**

- Browse the web, search, and fetch pages with built-in tools
- Remember things across conversations with persistent memory
- Execute scheduled tasks with cron-style scheduling
- Chat via Telegram (send it a message, it replies intelligently)
- Read and write files in its workspace for custom instructions and personas

[Full documentation →](zeroclaw/DOCS.md) | [Changelog →](zeroclaw/CHANGELOG.md)

---

## Installation

### One-click

<a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Ftonyputi%2Fhassio-addons">
  <img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" />
</a>

### Manual

1. In Home Assistant: **Settings → Add-ons → Add-on Store → ⋮ → Repositories**
2. Add this URL: `https://github.com/tonyputi/hassio-addons`
3. Find **ZeroClaw** in the store → Install → Configure → Start

### Configuration

| Option | Required | Default | Description |
| ------ | :------: | ------- | ----------- |
| `provider` | ✓ | `gemini` | AI provider: `gemini`, `openai`, `anthropic` |
| `api_key` | ✓ | | API key for the chosen provider |
| `model` | ✓ | `gemini-2.0-flash` | Model to use |
| `autonomy_mode` | ✓ | `semi` | `full` · `semi` · `manual` |
| `telegram_token` | | | Telegram bot token |
| `telegram_chat_id` | | | Telegram chat/user ID |

Persistent data (config, workspace, memory) lives at `/data/zeroclaw/` and survives restarts and updates.

---

## Why this add-on?

The existing community add-on compiles ZeroClaw from Rust source — that means **20+ minutes** of build time on a Raspberry Pi, high memory usage, and frequent build failures on constrained devices. This add-on uses official pre-built binaries from the [ZeroClaw GitHub releases](https://github.com/zeroclaw-labs/zeroclaw/releases), so installation is **under 30 seconds** on any supported device.

| | SeoFood/hassio-addons-zeroclaw | This add-on |
| -- | :---: | :---: |
| Install time on RPi | ~20 min | ~30 sec |
| Compiles from source | yes | no |
| ZeroClaw version | 0.1.x | 0.6.5 |
| Telegram config in UI | no | yes |
| S6-overlay supervision | no | yes |

---

## Support

- ZeroClaw documentation: [zeroclawlabs.ai](https://www.zeroclawlabs.ai)
- Issues with this add-on: [open an issue](https://github.com/tonyputi/hassio-addons/issues)
