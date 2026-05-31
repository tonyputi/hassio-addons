# Changelog

## 2026.5.28.0

- Bump OpenClaw to upstream `2026.5.28`: agent/Codex runtime recovery, channel delivery hardening (Matrix/iMessage/Slack/Discord/WhatsApp/Telegram/Teams), mobile and chat surfaces refresh, stricter input validation on Browser/Gateway/cron/Discord/Telegram

## 2026.4.15.1

- Fix browser addon auto-detection for Browserless Chromium v2.x: the old `/json/version` probe is v1-only and times out on v2. The new probe tries `/sessions` first (v2) with a `/json/version` fallback for v1, both with a 3s timeout per attempt

## 0.1.0

- Initial release
- OpenClaw npm package (no compilation required)
- Supports aarch64 (Raspberry Pi) and amd64
- S6-overlay process supervision
- Web terminal via ttyd on port 7681
- Gateway on port 38789
- Persistent workspace at `/share/openclaw/`
- Optional Home Assistant MCP integration
- Optional gateway pairing control
