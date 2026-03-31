# PicoClaw Add-on for Home Assistant

PicoClaw is an ultra-lightweight AI agent written in Go. It boots in under a second, uses less than 10MB of RAM, and supports 30+ LLM providers and 16 messaging platforms.

This add-on installs PicoClaw using pre-built binaries and runs the **launcher web UI** on port 18800 — no compilation required.

## First setup

1. Start the add-on
2. Open `http://<your-ha-ip>:18800` in your browser
3. Log in with the dashboard token shown in the add-on logs
4. Configure your **AI provider** and **API key** from the web UI
5. Add a **channel** (e.g. Telegram) to start chatting

> Provider, model, and channel configuration is handled entirely through the launcher web UI — not through HA add-on options.

## Configuration options

| Option            | Required | Default | Description |
| ----------------- | :------: | ------- | ----------- |
| `timezone`        | No       | `UTC`   | System timezone for cron scheduling (IANA format, e.g. `Europe/Rome`) |
| `ha_mcp_enabled`  | No       | `false` | Allow the AI agent to read and control Home Assistant entities via MCP |
| `tavily_api_key`  | No       | —       | Tavily API key for AI-optimized web search (see [Tavily search](#tavily-search)) |
| `browser_enabled` | No       | `false` | Enable Lightpanda CDP browser for web automation (see [Browser](#browser)) |

## Web UI

The PicoClaw launcher is available at `http://<your-ha-ip>:18800`.

On first access you'll be prompted for a **dashboard token**. Find it in the add-on logs:

```
Settings → Add-ons → PicoClaw → Log
```

Look for a line containing the token. Once logged in, the session is valid for 7 days.

From the web UI you can:
- Add and configure AI providers and API keys
- Set the default model
- Enable and configure messaging channels (Telegram, Discord, Slack, Matrix, IRC, and more)
- Start and stop the gateway
- View conversation history

## Home Assistant MCP

When `ha_mcp_enabled: true`, PicoClaw gains access to your Home Assistant instance via the Model Context Protocol (MCP). The agent can:

- Read entity states (lights, sensors, switches, climate, etc.)
- Turn entities on/off and change their attributes
- Access live context (areas, devices, services)

The add-on uses the Supervisor token automatically — no manual token setup required.

> **Security note:** Restrict channel access (e.g. Telegram `allow_from`) to your user ID to prevent unauthorized control of your home.

## Tavily search

When `tavily_api_key` is set, PicoClaw uses [Tavily](https://tavily.com) as its primary web search engine. Tavily is optimized for AI agents and can retrieve structured content from JavaScript-heavy sites (Booking.com, Airbnb, news sites, etc.) that DuckDuckGo cannot index effectively.

Get a free API key at [tavily.com](https://tavily.com) and paste it in the add-on options.

## Browser

When `browser_enabled: true`, the add-on starts **Lightpanda** — a lightweight Rust-based CDP browser (~30MB) — as a background service. PicoClaw connects to it on `ws://127.0.0.1:9222` and can use it to:

- Navigate websites and extract content
- Fill forms and click elements
- Render JavaScript-heavy pages

> Lightpanda is a lightweight browser — complex sites with heavy anti-bot measures (Google, some airline sites) may not work reliably. For straightforward web tasks it works well.

## Web terminal

The add-on includes a web-based terminal accessible via the sidebar panel (ingress). From the terminal you can inspect PicoClaw files, run `picoclaw` CLI commands, or edit workspace files directly.

## Persistent data

All PicoClaw data is stored in `/share/picoclaw/`:

- `.picoclaw/config.json` — managed by the launcher web UI
- `.picoclaw/workspace/` — workspace files (SOUL.md, MEMORY.md, IDENTITY.md, etc.)

You can edit workspace files using the Home Assistant **File Editor** add-on or via SSH.

## Support

- PicoClaw docs: https://picoclaw.io
- PicoClaw issues: https://github.com/sipeed/picoclaw/issues
- Issues with this add-on: https://github.com/tonyputi/hassio-addons/issues
