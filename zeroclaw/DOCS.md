# ZeroClaw Add-on for Home Assistant

ZeroClaw is a lightweight AI daemon with persistent memory, workspace files, cron scheduling, and tool integrations (web search, file operations, HTTP requests, and more).

This add-on installs ZeroClaw using pre-built binaries — no Rust compilation required. Startup time is under 30 seconds even on Raspberry Pi.

## Configuration

| Option | Required | Description |
| ------ | -------- | ----------- |
| `provider` | Yes | AI provider: `gemini`, `openai`, `anthropic` |
| `api_key` | Yes | API key for your chosen provider |
| `model` | Yes | Model name (e.g. `gemini-2.0-flash`, `gpt-4o`) |
| `autonomy_mode` | Yes | `full`, `semi`, or `manual` |
| `telegram_token` | No | Telegram bot token for chat integration |
| `telegram_chat_id` | No | Telegram chat/user ID to accept messages from |

## Persistent data

All ZeroClaw data is stored in `/data/zeroclaw/`:

- `config.toml` — generated on first start from add-on options
- `workspace/` — workspace files (SOUL.md, IDENTITY.md, MEMORY.md, etc.)

You can edit workspace files using the Home Assistant **File Editor** add-on or via SSH, at `/addon_configs/<slug>/` or through the add-on's data volume.

## Advanced configuration

After the first start, you can edit `/data/zeroclaw/config.toml` directly for options not exposed in the add-on UI. Changes take effect after restarting the add-on.

## Support

- ZeroClaw docs: https://www.zeroclawlabs.ai
- Issues: https://github.com/tonyputi/hassio-addons/issues
