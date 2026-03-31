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

| Option           | Required | Default | Description |
| ---------------- | :------: | ------- | ----------- |
| `timezone`       | No       | `UTC`   | System timezone for cron scheduling (IANA format, e.g. `Europe/Rome`) |
| `ha_mcp_enabled` | No       | `false` | Allow the AI agent to read and control Home Assistant entities via MCP |

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

## Persistent data

All PicoClaw data is stored in `/share/picoclaw/`:

- `.picoclaw/config.json` — managed by the launcher web UI
- `.picoclaw/workspace/` — workspace files (AGENT.md, SOUL.md, MEMORY.md, etc.)

You can edit workspace files using the Home Assistant **File Editor** add-on or via SSH.

## Support

- PicoClaw docs: https://picoclaw.io
- PicoClaw issues: https://github.com/sipeed/picoclaw/issues
- Issues with this add-on: https://github.com/tonyputi/hassio-addons/issues
