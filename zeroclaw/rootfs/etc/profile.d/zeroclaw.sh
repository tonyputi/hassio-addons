export HOME="/data/zeroclaw"
export PATH="/usr/local/bin:${PATH}"
cd "${HOME}" || true

cat <<'EOF'
 ______              ___  _
|__  / ___ _ __ ___/ __|| | __ ___ __ __
  / / / _ \ '__/ _ \__ \| |/ _` |\ \ /\ / /
 / /_|  __/ | | (_) |__) | | (_| | \ V  V /
/____|\___| |  \___/____/|_|\__,_|  \_/\_/
          |_|

ZeroClaw container shell. Available commands:

  zeroclaw agent          Start interactive chat session
  zeroclaw status         Show current configuration
  zeroclaw onboard        Re-run initial setup wizard
  zeroclaw cron list      List scheduled tasks
  zeroclaw channel list   List configured channels
  zeroclaw doctor         Run diagnostics

  Config:  /data/zeroclaw/.zeroclaw/config.toml
  Workspace: /data/zeroclaw/workspace/

EOF
