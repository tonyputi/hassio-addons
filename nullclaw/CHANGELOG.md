# Changelog

## 2026.5.29.0

- Bump NullClaw binary `2026.4.17` → `2026.5.29` (covers two upstream stable releases). Highlights:
  - **v2026.5.4**: Agent Skills RFC 0.2.0 support with nested skill discovery; Knowledge Graph Memory backend (SQLite recursive CTEs); tool customization config (`system_prompt`/`enabled` overrides, trigger-based prioritization, external `tool_customizations_file`); inbound router + mid-turn injection infra; Matrix pantalaimon E2EE proxy; `--workspace` / `--skill` CLI flags; encrypted tailscale `auth_key`; 3-tier risk classification + exec-prefix stripping; anti-spoofing boundaries for `web_fetch`/`web_search`
  - **v2026.5.29**: native ACP stdio adapter; NEAR AI Cloud + Atlas Cloud providers; Telegram `reply_to_message` context and subagent/polling delivery fixes; synchronous `/webhook` for paired-token workers; gateway stability (Discord/WebSocket watchdog, backoff, interrupt-safe stop, TLS leak fix); security harden on webhooks/HTTP secrets/cron shell jobs
- Align `Dockerfile` `ARG NULLCLAW_VERSION` default to match `build.yaml` (was lagging at `2026.4.9`). `build.yaml` is authoritative for HA builds; the drift was cosmetic but worth fixing.

## 0.1.0

- Initial release
- NullClaw v2026.4.4 pre-built binary (678 KB, ~1 MB RAM)
- Supports aarch64 (Raspberry Pi) and amd64
- S6-overlay process supervision
- Web terminal via ttyd on port 7681
- Gateway on port 43000
- Persistent workspace at `/share/nullclaw/`
- Optional Home Assistant MCP integration
- Optional gateway pairing control
- Auto-detect browserless_chrome addon for browser automation
