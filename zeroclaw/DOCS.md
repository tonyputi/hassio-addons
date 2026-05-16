# ZeroClaw Add-on for Home Assistant

ZeroClaw is a lightweight AI daemon with persistent memory, workspace files, cron scheduling, and tool integrations (web search, file operations, HTTP requests, browser automation, and more).

This add-on installs ZeroClaw using pre-built binaries — no Rust compilation required. Startup time is under 30 seconds even on Raspberry Pi.

## Configuration

| Option            | Required | Default | Description |
| ----------------- | :------: | ------- | ----------- |
| `timezone`        | Yes      | `UTC`   | IANA timezone for cron scheduling (e.g. `Europe/Rome`, `America/New_York`) |
| `ha_mcp_enabled`  | No       | `false` | Allow the AI agent to read and control Home Assistant entities (lights, sensors, automations) via MCP |
| `gateway_pairing` | No       | `true`  | Require a one-time pairing code on first access to the web dashboard. Disable only on a trusted local network |

## First start

On first install, no configuration exists yet. Open the **web terminal** from the add-on UI and run:

```bash
zeroclaw onboard
```

The interactive wizard will guide you through provider, model, API key, and channel setup. Once complete, restart the add-on — the daemon will start normally.

Provider, model, API key, Telegram, and all other settings are managed via `zeroclaw onboard` or the **web dashboard** at `http://<your-ha-ip>:42617`.

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

> **Security note:** With MCP enabled, ZeroClaw's autonomy level is set to `full` so HA tool calls are never blocked. Restrict Telegram access via the web dashboard to prevent unauthorized control of your home.

## Web terminal

The add-on includes a browser-based terminal (ttyd) accessible from the **ZeroClaw Terminal** tab in the add-on UI. Use it to:

- Inspect or edit `~/.zeroclaw/config.toml`
- Run `zeroclaw agent` for interactive sessions
- Manage workspace files

## Persistent data

All ZeroClaw data is stored in `/share/zeroclaw/`:

- `.zeroclaw/config.toml` — generated on first start, then managed via the web dashboard
- `.zeroclaw/workspace/` — workspace files (SOUL.md, IDENTITY.md, MEMORY.md, TOOLS.md, etc.)

You can edit workspace files using the Home Assistant **File Editor** add-on or via SSH.

After the first start, you can edit `config.toml` directly for options not exposed in the add-on UI. Changes take effect after restarting the add-on.

## Webhook channel (SOP triggers)

ZeroClaw v0.7.5+ ships a dedicated **webhook channel** that exposes an HTTP endpoint for triggering Standard Operating Procedures (SOPs) on demand. This is the canonical way to fire a specific SOP from external systems (Home Assistant automations, Node-RED, cron, curl) without sending a free-form chat message to the main gateway.

### Enable the channel

The channel is opt-in. Add to `/share/zeroclaw/.zeroclaw/config.toml`:

```toml
[channels.webhook]
enabled = true
port = 42618
listen_path = "/sops"
# secret = "your-shared-secret"   # optional, HMAC-SHA256 signature verification
```

Port `42618` is exposed by this add-on. After saving, restart the add-on.

### Define a SOP

SOPs live in `/share/zeroclaw/.zeroclaw/workspace/sops/<name>/`. Each SOP is a directory with two files:

```
sops/
  ping/
    SOP.toml      # metadata + trigger definition
    SOP.md        # instructions the agent follows when triggered
```

Declare a webhook trigger in `SOP.toml`:

```toml
name = "ping"
description = "Health check SOP — replies with a pong and timestamp"

[trigger]
type = "webhook"
```

`SOP.md` contains the prompt the agent receives when the SOP fires:

```markdown
You were triggered by a webhook. Respond with: "pong" plus the current UTC timestamp.
Do not call any tool. Keep the response under 50 characters.
```

### Trigger from outside

```bash
curl -X POST http://<ha-ip>:42618/sops \
  -H "Content-Type: application/json" \
  -d '{}'
```

The channel routes the incoming POST to the matching SOP and the agent executes `SOP.md` against your configured model.

### Security

- The channel binds on `0.0.0.0:42618` inside the container, which Home Assistant exposes on the host LAN. Anyone on your network can hit it.
- Set `secret` in `[channels.webhook]` to require an HMAC-SHA256 signature on incoming requests.
- Do not expose port 42618 to the public internet without authentication.

## Browser automation

Browser automation is **not available by default**. To enable it, install the **Browserless Chromium** add-on from the [alexbelgium repository](https://github.com/alexbelgium/hassio-addons).

Once installed and running, ZeroClaw automatically detects it at boot and configures the browser tool to use it. No manual configuration is needed — just restart ZeroClaw after installing the browser add-on.

With browser automation enabled, the AI agent can:
- Open and navigate web pages
- Fill forms, click buttons, take screenshots
- Extract content from JavaScript-heavy sites

Without the browser add-on, all other tools (web search, memory, MCP, scheduling, file operations) continue to work normally.

## Support

- ZeroClaw docs: https://www.zeroclawlabs.ai
- Issues: https://github.com/tonyputi/hassio-addons/issues
