# Changelog

## 0.3.1.1

- Replace add-on icon with the official upstream PicoClaw mascot (blue prawn with the "P" microchip and coral claw), set on a navy rounded-badge background with a subtle highlight ring. Drops the outdated `clawdchat.ai` badge artwork.

## 0.3.1.0

- Bump PicoClaw to upstream `v0.3.1`. Highlights: SSRF/private-IP hardening (ISATAP literal guard, block private IPv4 embeds, tighter OneBot inbound media handling), new NEAR AI Cloud provider, configurable remote cron commands, `RegisterChannelSettings` hook for out-of-tree channels, Telegram forum/topic thread ID fix, Gemini `thought_signature` fix, friendlier auth error messages, and broad robustness fixes (panic recovery on core goroutines, atomic lock-store repair, numerous `Close()`/error-path fixes).

## 0.2.9.1

- Add `browser_stealth` HA add-on option (default `true`). When enabled, the CDP URL written to `~/.agent-browser/config.json` is suffixed with `?stealth=true`, which makes Browserless v2 (alexbelgium add-on) attach `puppeteer-extra-plugin-stealth` to every browser session it spawns. The plugin patches `navigator.webdriver`, `navigator.plugins`, `navigator.languages`, the WebGL/Canvas fingerprint, and the `chrome.runtime` object to evade common anti-bot detection. Toggle off only when a specific site breaks under stealth — without the suffix, headless Chrome is trivially detectable client-side.

## 0.2.9.0

- Bump PicoClaw to upstream `v0.2.9`: MCP section in config web UI, `pretty_print`/`disable_escape_html` defaults for `tool_feedback`, MQTT channel stop fix, Gemini MCP schema sanitization, agent discovery prompt, delegate tool, Bedrock streaming, network error retry

## 0.2.6.1

- Fix browser addon auto-detection for Browserless Chromium v2.x: the old `/json/version` probe is v1-only and times out on v2. The new probe tries `/sessions` first (v2) with a `/json/version` fallback for v1, both with a 3s timeout per attempt

## 0.2.4.15

- Fix s6 service registration and finish scripts
- Various stability improvements

## 0.2.4.12

- Update PicoClaw binary to v0.2.4
- Add `tavily_api_key` option — AI-optimized web search (Booking, Airbnb, news) via Tavily API
- Add `ha_mcp_enabled` option — read and control Home Assistant entities via MCP
- Remove dead `picoclaw` gateway s6 service (gateway started internally by launcher)
- Add finish scripts for picoclaw-launcher and ttyd services
- Add `user/type` bundle file for correct s6 service registration
- Add ingress on port 7681 for web terminal access from HA sidebar

## 0.2.4

- Initial release
- Downloads pre-built PicoClaw binary (no Go compilation required)
- Supports aarch64 (Raspberry Pi) and amd64
- S6-overlay process supervision
- Web launcher UI on port 18800
- Web terminal via ttyd on port 7681
- Persistent workspace at `/share/picoclaw/`
