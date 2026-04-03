# Changelog

## 0.6.8.9

- Install system Chromium and point agent-browser/Puppeteer to it via env vars
- Fixes "Chrome not found" error when using ZeroClaw browser tool

## 0.6.8.8

- Add Node.js and `agent-browser` npm package for browser automation support
- Enables ZeroClaw browser tool (`backend = "agent_browser"`) for navigating websites without APIs

## 0.6.8

- Update ZeroClaw binary to v0.6.8
- Simplify HA configuration to 3 options: `timezone`, `ha_mcp_enabled`, `gateway_pairing`
- Remove all provider/model/key/channel options from HA — run `zeroclaw onboard` from the web terminal on first install
- Fix ttyd HOME path (`/data/zeroclaw` → `/share/zeroclaw`) and add `cd $HOME` for correct terminal directory
- Add symlink `/usr/local/var/zeroclaw` → `/share/zeroclaw/.zeroclaw` for persistent data across restarts
- Add `user/type` bundle file for correct s6 service registration
- Add finish scripts for ttyd and lightpanda services
- Add ingress on port 7681 for web terminal access from HA sidebar

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
