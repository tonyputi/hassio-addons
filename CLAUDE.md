# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A Home Assistant add-on repository containing four AI agent add-ons: **ZeroClaw**, **PicoClaw**, **OpenClaw**, and **NullClaw**. Each add-on packages an upstream AI agent binary/package as a HA add-on using s6-overlay, ttyd, and a minimal set of HA config options.

There are no build steps, tests, or CI pipelines to run locally. Development means editing add-on files and pushing to GitHub — HA pulls from the repo directly.

## Add-on structure

Every add-on follows this layout:

```
<addon>/
├── config.yaml          # HA add-on manifest (slug, ports, options, schema)
├── build.yaml           # Base image + version ARG
├── Dockerfile           # Binary/npm install + ttyd + rootfs copy
├── CHANGELOG.md
├── DOCS.md
├── icon.png / logo.png
├── translations/en.yaml # Human-readable option labels
└── rootfs/etc/s6-overlay/s6-rc.d/
    ├── user/            # type=bundle, contents.d/<service> + ttyd
    ├── <service>/       # type=longrun, run + finish
    └── ttyd/            # type=longrun, run + finish, dependencies.d/<service>
```

`ttyd/dependencies.d/<service>` (empty file) makes ttyd wait for the main service before starting.

## Conventions shared across all add-ons

- **Base image**: `ghcr.io/home-assistant/{arch}-base-debian:bookworm` for both `aarch64` and `amd64`
- **ttyd**: always version 1.7.7, downloaded from GitHub releases, port 7681 (ingress)
- **Persistent data**: `/share/<addon>/` — survives restarts and updates
- **Config location**: `/share/<addon>/.<addon>/` (e.g. `.zeroclaw/config.toml`, `.nullclaw/config.json`)
- **HA options**: exactly three — `timezone` (str), `ha_mcp_enabled` (bool), `gateway_pairing` (bool) — except PicoClaw which has no `gateway_pairing`
- **boot**: `auto` on all four
- **panel_icon**: `mdi:robot` on all four
- **run scripts**: use `bashio::config`, `bashio::var.true/false`, `bashio::log.info/warning/fatal`
- **MCP injection**: written into the add-on's config file via `jq` on every boot (not persisted as HA config)
- **Browser auto-detect**: all run scripts check `http://localhost:3000/json/version` at boot; if `browserless_chrome` (alexbelgium) is running, they configure the CDP endpoint automatically

## Per-add-on specifics

| | ZeroClaw | PicoClaw | OpenClaw | NullClaw |
| --- | --- | --- | --- | --- |
| Install | Binary (Rust, GitHub releases) | Binary (Go, GitHub releases) | `npm install -g openclaw` | Binary (Zig, GitHub releases) |
| Config format | TOML (`config.toml`) | JSON (`config.json`) | JSON (`openclaw.json`) | JSON (`config.json`) |
| Gateway port | 42617 | 18800 | 38789 | 43000 |
| First run | `zeroclaw onboard` | launcher web UI | `openclaw configure` | `nullclaw onboard --interactive` |
| `gateway_pairing` | `require_pairing` in TOML | — (always auth) | `dangerouslyDisableDeviceAuth` in JSON | `require_pairing` in JSON |
| MCP key | `[[mcp.servers]]` TOML append | `tools.mcp.servers` jq merge | `mcpServers` jq merge | `mcp_servers` jq merge |
| Browser CDP | `~/.agent-browser/config.json` | `~/.agent-browser/config.json` | `cdpUrl` in openclaw.json | `~/.agent-browser/config.json` |

## Versioning and releases

- Bump `version` in `config.yaml` to trigger a new HA release
- Bump `ROOTFS_VERSION` ARG in `Dockerfile` when changing `rootfs/` scripts (forces Docker layer rebuild)
- `build.yaml` `args` version (e.g. `ZEROCLAW_VERSION`) controls the upstream binary version

## Workflow

1. Edit files locally
2. `git add` specific files (never `-A` to avoid accidental secrets)
3. Commit with Conventional Commits (`feat:`, `fix:`, `chore:`, `docs:`)
4. `git push` — HA refreshes the repo from GitHub
5. In HA: Settings → Add-ons → Add-on Store → ⋮ → Check for updates, then update/rebuild the add-on

## Open issues

- **tonyputi/hassio-addons#3** — NanoClaw: blocked, requires Docker-in-Docker; monitor upstream for a containerless install path
