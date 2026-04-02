# Changelog

## 0.6.8

- Update ZeroClaw binary to v0.6.8
- Simplify HA configuration to 4 options: `api_key`, `timezone`, `ha_mcp_enabled`, `gateway_pairing`
- Remove `provider`, `model`, `telegram_token`, `telegram_allowed_users` from HA options — managed via the web dashboard
- First-run onboard now bootstraps with API key only; complete setup via web dashboard at port 42617

## 0.6.7

- Update ZeroClaw binary to v0.6.7
- Add `ha_mcp_enabled` option — let the AI agent read and control Home Assistant entities via MCP (uses Supervisor token automatically, no manual token needed)
- Add `gateway_pairing` option — control whether the web dashboard requires a one-time pairing code
- Add `timezone` option for cron scheduling
- Add web dashboard on port 42617 (replaces ingress, which is incompatible with the SPA architecture)
- Add ttyd web terminal accessible from the add-on UI
- Add Lightpanda headless browser for ZeroClaw browser tool
- Fix `$SHELL not set` warning in ZeroClaw doctor
- Fix MCP tools blocked when autonomy level was `supervised` — now set to `full` when MCP is enabled
- Data directory changed from `/data/zeroclaw/` to `/share/zeroclaw/` for cross-add-on accessibility
- MCP `deferred_loading` is forced to `false` when HA MCP is enabled so tools are visible in agent context

## 0.6.5

- Initial release
- Downloads pre-built ZeroClaw binary (no Rust compilation required)
- Supports aarch64 (Raspberry Pi) and amd64
- S6-overlay process supervision
- Configurable provider, model, and API key
- Optional Telegram bot integration
- Persistent workspace at `/data/zeroclaw/`
