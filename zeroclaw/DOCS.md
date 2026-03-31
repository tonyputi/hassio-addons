# ZeroClaw Add-on for Home Assistant

ZeroClaw is a lightweight AI daemon with persistent memory, workspace files, cron scheduling, and tool integrations (web search, file operations, HTTP requests, browser automation, and more).

This add-on installs ZeroClaw using pre-built binaries — no Rust compilation required. Startup time is under 30 seconds even on Raspberry Pi.

## Configuration

| Option                   | Required | Default                          | Description |
| ------------------------ | :------: | -------------------------------- | ----------- |
| `provider`               | Yes      | `gemini`                         | AI provider: `gemini`, `openai`, `anthropic`, `mistral`, `groq`, `deepseek`, `xai`, `openrouter`, `ollama`, `other` |
| `api_key`                | Yes      | —                                | API key for your chosen provider |
| `model`                  | Yes      | `gemini-2.0-flash`               | Model name (e.g. `gemini-2.0-flash`, `gpt-4o`, `claude-opus-4-6`) |
| `timezone`               | Yes      | `UTC`                            | IANA timezone for cron scheduling (e.g. `Europe/Rome`, `America/New_York`) |
| `telegram_token`         | No       | —                                | Telegram bot token — create one via [@BotFather](https://t.me/BotFather) |
| `telegram_allowed_users` | No       | `*`                              | Comma-separated Telegram user IDs or usernames allowed to chat. Use `*` to allow everyone (not recommended) |
| `ha_mcp_enabled`         | No       | `false`                          | Allow the AI agent to read and control Home Assistant entities (lights, sensors, automations) via MCP |
| `gateway_pairing`        | No       | `true`                           | Require a one-time pairing code on first access to the web dashboard. Disable only on a trusted local network |

### Provider `other`

Select `other` if your provider is not in the list. ZeroClaw will start without configuring a provider — use the **Web terminal** to manually edit `~/.zeroclaw/config.toml`.

## Web dashboard

The ZeroClaw web dashboard is available at `http://<your-ha-ip>:42617`.

> The dashboard is a single-page application and cannot be proxied through the Home Assistant UI. You must access it directly on port 42617.

**Pairing:** With `gateway_pairing: true` (default), the first access shows a pairing code on the dashboard itself. Copy the code and confirm it. Once paired, the dashboard opens without a code until the session is cleared.

To skip pairing entirely, set `gateway_pairing: false`. Only do this on a private, trusted network.

## Home Assistant MCP

When `ha_mcp_enabled: true`, ZeroClaw gains full access to your Home Assistant instance via the Model Context Protocol (MCP). The agent can:

- Read entity states (lights, sensors, switches, climate, etc.)
- Turn entities on/off and change their attributes
- Access live context (areas, devices, services)

The add-on uses the Supervisor token automatically — no manual token setup is required.

> **Security note:** With MCP enabled, ZeroClaw's autonomy level is set to `full` so HA tool calls are never blocked. Restrict Telegram access with `telegram_allowed_users` to prevent unauthorized control of your home.

## Web terminal

The add-on includes a browser-based terminal (ttyd) accessible from the **ZeroClaw Terminal** tab in the add-on UI. Use it to:

- Inspect or edit `~/.zeroclaw/config.toml`
- Run `zeroclaw agent` for interactive sessions
- Manage workspace files

## Persistent data

All ZeroClaw data is stored in `/share/zeroclaw/`:

- `.zeroclaw/config.toml` — generated on first start from add-on options
- `.zeroclaw/workspace/` — workspace files (SOUL.md, IDENTITY.md, MEMORY.md, TOOLS.md, etc.)

You can edit workspace files using the Home Assistant **File Editor** add-on or via SSH.

After the first start, you can edit `config.toml` directly for options not exposed in the add-on UI. Changes take effect after restarting the add-on.

## Support

- ZeroClaw docs: https://www.zeroclawlabs.ai
- Issues: https://github.com/tonyputi/hassio-addons/issues
