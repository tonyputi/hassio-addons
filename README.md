<p align="center">
  <img src="zeroclaw/icon.png" alt="ZeroClaw" width="72" />
  &nbsp;&nbsp;&nbsp;
  <img src="picoclaw/icon.png" alt="PicoClaw" width="72" />
  &nbsp;&nbsp;&nbsp;
  <img src="openclaw/icon.png" alt="OpenClaw" width="72" />
</p>

<h1 align="center">AI Add-ons for Home Assistant</h1>

<p align="center">
  <a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Ftonyputi%2Fhassio-addons">
    <img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" alt="Add to Home Assistant" />
  </a>
</p>

<p align="center">
  Pre-built AI agent add-ons for Home Assistant — no compilation, no waiting, no build failures.<br/>
  Supports Raspberry Pi (aarch64) and standard x86_64 machines.
</p>

---

## Add-ons

| | [ZeroClaw](zeroclaw/) | [PicoClaw](picoclaw/) | [OpenClaw](openclaw/) |
| --- | --- | --- | --- |
| **Based on** | [ZeroClaw Labs](https://www.zeroclawlabs.ai) | [Sipeed PicoClaw](https://picoclaw.io) | [OpenClaw](https://openclaw.ai) |
| **Language** | Rust | Go | Node.js |
| **RAM** | ~100MB | < 10MB | ~150MB |
| **Web UI** | Port 42617 (built-in dashboard) | Port 18800 (launcher) | Port 38789 (gateway) |
| **Web terminal** | ✓ (ttyd, ingress) | ✓ (ttyd, ingress) | ✓ (ttyd, ingress) |
| **Telegram** | ✓ (via web UI) | ✓ (via web UI) | ✓ (via gateway) |
| **Home Assistant MCP** | ✓ | ✓ | ✓ |
| **Web search** | DuckDuckGo | DuckDuckGo + Tavily (optional) | Built-in |
| **Channels** | Telegram | Telegram, Discord, Matrix, Slack, IRC, and more | Telegram, WhatsApp, and more |
| **Best for** | Full-featured daemon with persistent memory | Ultra-lightweight, multi-channel, low-power devices | Node.js-based agent with gateway UI |

---

## Installation

### One-click

<a href="https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Ftonyputi%2Fhassio-addons">
  <img src="https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg" />
</a>

### Manual

1. In Home Assistant go to **Settings → Add-ons → Add-on Store**
2. Click **⋮ → Repositories** and add: `https://github.com/tonyputi/hassio-addons`
3. Find **ZeroClaw**, **PicoClaw**, or **OpenClaw** in the store and install

---

## ZeroClaw

<p>
  <img src="https://img.shields.io/badge/ZeroClaw-v0.6.8-blue" />
  &nbsp;
  <img src="https://img.shields.io/badge/Raspberry%20Pi-supported-brightgreen" />
  &nbsp;
  <img src="https://img.shields.io/badge/amd64-supported-brightgreen" />
</p>

A full-featured AI daemon with persistent memory, workspace files, cron scheduling, web dashboard, and web terminal. Only `timezone` in HA — everything else configured via `zeroclaw onboard` from the built-in terminal.

**Quick start:** Install, open the web terminal, run `zeroclaw onboard`, then restart the add-on. The web dashboard is at `http://<ha-ip>:42617`.

→ [ZeroClaw documentation](zeroclaw/DOCS.md) · [Changelog](zeroclaw/CHANGELOG.md) · [zeroclawlabs.ai](https://www.zeroclawlabs.ai)

---

## PicoClaw

<p>
  <img src="https://img.shields.io/badge/PicoClaw-v0.2.4.12-blue" />
  &nbsp;
  <img src="https://img.shields.io/badge/Raspberry%20Pi-supported-brightgreen" />
  &nbsp;
  <img src="https://img.shields.io/badge/amd64-supported-brightgreen" />
  &nbsp;
  <img src="https://img.shields.io/badge/RAM-%3C10MB-orange" />
</p>

An ultra-lightweight AI agent written in Go. Boots in under a second, uses less than 10MB of RAM. Configure providers, models, and channels through the browser-based launcher UI at port 18800.

**Features:**
- **30+ LLM providers** — Gemini, OpenAI, Anthropic, DeepSeek, Groq, Ollama, and more
- **16 messaging channels** — Telegram, Discord, Matrix, Slack, IRC, WhatsApp, and more
- **Home Assistant MCP** — read and control entities (lights, sensors, automations) directly from chat
- **Tavily search** — AI-optimized web search for real-world data (Booking, Airbnb, news) — optional API key
- **Web terminal** — built-in ttyd terminal accessible from the HA sidebar

**Quick start:** Set `timezone` in the add-on options, start, then open `http://<ha-ip>:18800` to complete setup.

→ [PicoClaw documentation](picoclaw/DOCS.md) · [picoclaw.io](https://picoclaw.io)

---

## OpenClaw

<p>
  <img src="https://img.shields.io/badge/OpenClaw-v0.1.0-blue" />
  &nbsp;
  <img src="https://img.shields.io/badge/Raspberry%20Pi-supported-brightgreen" />
  &nbsp;
  <img src="https://img.shields.io/badge/amd64-supported-brightgreen" />
</p>

A Node.js-based AI agent with a browser gateway. Supports multiple LLM providers and messaging channels. Runs the `openclaw gateway` on port 38789 and exposes a web terminal for configuration.

**Quick start:** Install, open the web terminal from the sidebar, run `openclaw configure`, then restart the add-on. The gateway is at `http://<ha-ip>:38789`.

**Features:**
- **Multiple LLM providers** — OpenAI, Anthropic, Gemini, and more
- **Home Assistant MCP** — read and control entities via chat
- **Gateway pairing** — one-time device pairing for secure access
- **Web terminal** — built-in ttyd terminal accessible from the HA sidebar

→ [OpenClaw documentation](openclaw/DOCS.md) · [Changelog](openclaw/CHANGELOG.md) · [openclaw.ai](https://openclaw.ai)

---

## Support

- Issues with these add-ons: [open an issue](https://github.com/tonyputi/hassio-addons/issues)
- ZeroClaw: [zeroclawlabs.ai](https://www.zeroclawlabs.ai)
- PicoClaw: [picoclaw.io](https://picoclaw.io)
- OpenClaw: [openclaw.ai](https://openclaw.ai)
