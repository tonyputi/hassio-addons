# OpenClaw

OpenClaw AI assistant as a Home Assistant add-on, optimized for HA with s6-overlay process supervision and a minimal configuration surface.

## First Run

After installing the add-on, open the web terminal from the sidebar and run:

```bash
openclaw configure
```

This will guide you through provider and model selection. Configuration is saved to `/share/openclaw/.openclaw/openclaw.json`.

## Web Terminal

The terminal is accessible from the HA sidebar (ingress). It runs `bash` in `/share/openclaw/` — your persistent workspace.

## Gateway

The OpenClaw gateway is exposed on port **38789**. Access it from your browser at:

```
http://<your-ha-ip>:38789/
```

## Home Assistant MCP

Enable `ha_mcp_enabled` in the add-on configuration to allow the AI agent to read and control Home Assistant entities (lights, sensors, automations, timers, etc.).

No manual token configuration is required — the Supervisor token is used automatically.

## Gateway Pairing

When `gateway_pairing` is enabled (default), the gateway requires a one-time pairing code on first access from a new device. Disable only on trusted local networks.

## Persistent Data

All data is stored in `/share/openclaw/` and survives add-on updates and restarts:

- `.openclaw/openclaw.json` — main configuration
- `workspace/` — agent workspace (skills, memory, etc.)
