# Changelog

## 0.8.0.3

- Refactor the boot run script to a "V3-first" pipeline: the upstream V2→V3 migrator is treated as a best-effort transform whose output is never trusted as final, and the daemon never sees a config we haven't sanitised. The flow becomes Phase A migrate (one-time) → Phase B read HA options → Phase C V3 sanitize (unconditional) → Phase D gateway → Phase E HA MCP inject (conditional) → Phase F browser auto-detect → Phase G validation → Phase H daemon.
- V3 sanitize is now **unconditional**: it runs every boot regardless of `ha_mcp_enabled`. Previously the strip-three-shapes awk lived inside the MCP injection block, so toggling MCP off left migrator orphans (`[mcp.servers.headers]`) accumulating in the file. Now they get cleared every restart.
- Add a validation phase before launching the daemon: `zeroclaw config list >/dev/null` loads + parses + deserialises the whole schema. On failure the run script saves `config.toml.invalid-<timestamp>` next to the live file and aborts with a `bashio::log.fatal` pointing at the issue — instead of leaving the daemon to crash-loop with a cryptic "malformed security-critical sections (<entire-config>)".

## 0.8.0.2

- Fix HA MCP not loading after 0.8.0.1. The previous fix wrote `[mcp.servers.home-assistant]` (dotted form), which is syntactically valid TOML but silently ignored by the daemon: V3 `#[natural_key = "name"]` on `Vec<McpServerConfig>` is a dashboard/TUI affordance, not a serde custom deserializer — disk deserialization still requires `[[mcp.servers]]` (array-of-tables). Revert the inject to AOT. The strip-three-shapes awk already prevents duplicate-key conflicts with the migrator orphan, so AOT re-injection is safe.

## 0.8.0.1

- Fix daemon crash-loop (`Config contains malformed security-critical sections (<entire-config>)`) after the 0.7.5.4 → 0.8.0.0 upgrade. Upstream's V2→V3 migrator emits a `[mcp.servers.headers]` orphan dotted sub-table from any V2 `[[mcp.servers]]` whose `headers` field is an inline-table, dropping `name`/`transport`/`url`. The run script then appended `[[mcp.servers]]` for HA MCP, declaring `mcp.servers` as both a table and an array → duplicate-key TOML parse error.
- Run script now strips three shapes before re-injecting HA MCP: V2 `[[mcp.servers]]` with `name = "home-assistant"`, V3 dotted `[mcp.servers.home-assistant]` plus its sub-tables, and the migrator orphan `[mcp.servers.headers]`. User-defined MCP entries (other names, other forms) are preserved.
- HA MCP is now injected in V3-native dotted form (`[mcp.servers.home-assistant]` + `[mcp.servers.home-assistant.headers]`) to coexist cleanly with anything else the daemon writes under `mcp.servers.*`.

## 0.8.0.0

- **Major upstream release**: bump ZeroClaw binary to v0.8.0. See [upstream release notes](https://github.com/zeroclaw-labs/zeroclaw/releases/tag/v0.8.0) for the full list.
- **Multi-agent runtime**: a single daemon now runs many named agents, each with its own workspace, memory, model provider, security policy, and channels. Existing single-agent configs are auto-migrated into a `default` agent.
- **Config schema V3**: V2→V3 migration is committed to disk on first boot via `zeroclaw config migrate` (idempotent). The marker file flips from `.v2_migrated` to `.v3_migrated`. On-disk filesystem layout moves `workspace/` → `agents/default/workspace/` (handled by the daemon on first load).
- **`zerocode` terminal UI**: new TUI binary bundled in the tarball and symlinked into `PATH`. Launch from the add-on web terminal with `zerocode`.
- **Install root**: explicit `ZEROCLAW_CONFIG_DIR=/share/zeroclaw/.zeroclaw` is now exported at boot (priority 1 in V3 path resolution); the legacy `/usr/local/var/zeroclaw` symlink is dropped.
- **`env_vars.conf` path**: moves from `workspace/config/env_vars.conf` to `agents/default/workspace/config/env_vars.conf` to match the per-agent V3 workspace layout. Update any skill that hardcoded the legacy path.
- **Lean default channel bundle**: the prebuilt linux-gnu binary ships ACP, webhook, email, and Telegram out of the box; other channels (Discord, Slack, Matrix, IRC, WhatsApp, etc.) are now opt-in build features and **not available** in this add-on's binary.
- **Webhook channel**: rewritten in V3 as `[channels.webhook.<alias>]` (map of named webhooks). The 0.7.x `[channels.webhook]` form is auto-migrated by the daemon; the exposed port `42618/tcp` is unchanged.
- **Tunnel**: `[tunnel] provider = "..."` is renamed to `[tunnel] tunnel_provider = "..."` in V3 (auto-migrated). `cloudflared` ships unchanged for users who run a Cloudflare Tunnel.
- **Gateway / MCP TOML shape**: `[gateway]` and top-level `[[mcp.servers]]` are byte-compatible with V3; the add-on's on-boot sed/awk autopatch keeps working unchanged.
- **Security hardening**: per-agent tool allowlists enforced at every dispatch, bearer-token revocation on device rotation/deletion, private-host allowlists for outbound HTTP, Canvas iframe sandbox tightened (GHSA-f385-f6h2-3gqj).

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
