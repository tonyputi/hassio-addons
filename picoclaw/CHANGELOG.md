# Changelog

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
