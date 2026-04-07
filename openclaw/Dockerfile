ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG OPENCLAW_VERSION="2026.4.2"

# Install Node.js 22 (OpenClaw requires Node 20+, bookworm ships Node 18)
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
      | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] \
      https://deb.nodesource.com/node_22.x nodistro main" \
      > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      nodejs \
      jq \
    && rm -rf /var/lib/apt/lists/*

# Verify Node.js version
RUN node --version | grep -E '^v22\.' || { echo "ERROR: Node.js 22 required"; exit 1; }

# Install OpenClaw and required peer dependencies
RUN npm install -g openclaw@${OPENCLAW_VERSION} @buape/carbon --audit=false --fund=false

# Install ttyd (consistent with ZeroClaw/PicoClaw pattern)
RUN ARCH=$(uname -m | sed 's/x86_64/x86_64/;s/aarch64/aarch64/') && \
    curl -fsSL \
      "https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.${ARCH}" \
      -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

ARG ROOTFS_VERSION=4
COPY rootfs /
RUN chmod +x \
    /etc/s6-overlay/s6-rc.d/openclaw/run \
    /etc/s6-overlay/s6-rc.d/openclaw/finish \
    /etc/s6-overlay/s6-rc.d/ttyd/run \
    /etc/s6-overlay/s6-rc.d/ttyd/finish
