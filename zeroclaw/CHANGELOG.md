# Changelog

## 0.7.5.4

- Fix env_vars injection and `env_vars.conf` accumulating duplicates (observed 32× duplication at runtime). Replace `bashio::config` index iteration with a `jq`-based read of `/data/options.json` using `unique_by(.name)`. Atomic write via tmp file. `env_vars.conf` is chmod `600` since it can contain credentials

## 0.7.5.3

- Write `gateway.web_dist_dir` into `config.toml` instead of passing it via `ZEROCLAW_WEB_DIST_DIR`. The dashboard's drift check compares in-memory config to on-disk values; the env-var-only path was flagged as "1 path differs from on-disk". Now the path lives in the TOML and the run script keeps it in sync on every boot

## 0.7.5.2

- Fix browser addon auto-detection for Browserless Chromium v2.x: the old `/json/version` probe is v1-only and times out on v2. The new probe tries `/sessions` first (v2) with a `/json/version` fallback for v1, both with a 3s timeout per attempt

## 0.7.5.1

- Expose port `42618/tcp` for the `[channels.webhook]` channel (HTTP endpoint for SOP triggers). The channel is opt-in: enable and configure it in `config.toml` to start using SOP webhook triggers

## 0.7.5.0

- Update ZeroClaw binary to v0.7.5
- Ship the prebuilt web dashboard: install path moved to `/opt/zeroclaw/` and `ZEROCLAW_WEB_DIST_DIR=/opt/zeroclaw/web/dist` exported at startup
- Web onboarding flow at `/onboard` (schema-driven, full first-run UI in the browser)
- Schema-driven config editor at `/config` with drift detection and per-row diff
- Personality editor (CodeMirror) for the 7 runtime markdown files (`SOUL.md`, `IDENTITY.md`, `USER.md`, `AGENTS.md`, `TOOLS.md`, `HEARTBEAT.md`, `MEMORY.md`)
- Live model switching, stop button, manual cron trigger in the dashboard
- OpenAPI 3.1 spec at `/api/openapi.json`, Scalar explorer at `/api/docs`
- ACP `session/cancel`, tool-approval back-channel, rejection of concurrent `session/prompt`
- Per-provider pricing with cost/token usage recorded on every gateway turn

## 0.7.4.2

- Write `env_vars` from HA config to `workspace/config/env_vars.conf` at startup so agent SOPs can read credentials via `file_read` (the shell tool cannot access env vars under `workspace_only` security policy)

## 0.7.4.1

- Install `cloudflared` 2026.3.0 in the Docker image to support Cloudflare Tunnel (`[tunnel] provider = "cloudflare"` in config.toml)

## 0.7.4.0

- Update ZeroClaw binary to v0.7.4
- Onboarding rewrite: schema-driven, idempotent, container-aware URLs for local AI providers
- New session management tools: SessionResetTool, SessionDeleteTool, SessionsCurrentTool
- Web dashboard: message deletion, clear-all, compact mode, cron job config UI
- Runtime fix: self-heal orphaned tool_result blocks on load and compaction
- Cron fix: prevent memory snowball accumulation in agent jobs
- New PostgreSQL memory backend
- Provider fixes: Bedrock omits temperature for Opus 4.7, MiniMax native tool calling enabled

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
- Add finish scripts for ttyd service
- Add ingress on port 7681 for web terminal access from HA sidebar

## 0.6.7

- Update ZeroClaw binary to v0.6.7
- Add `ha_mcp_enabled` option — let the AI agent read and control Home Assistant entities via MCP (uses Supervisor token automatically, no manual token needed)
- Add `gateway_pairing` option — control whether the web dashboard requires a one-time pairing code
- Add `timezone` option for cron scheduling
- Add web dashboard on port 42617 (replaces ingress, which is incompatible with the SPA architecture)
- Add ttyd web terminal accessible from the add-on UI
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
