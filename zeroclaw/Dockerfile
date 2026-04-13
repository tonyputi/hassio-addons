ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG ZEROCLAW_VERSION="0.6.9"
ARG AGENT_BROWSER_VERSION="0.25.3"
ARG YQ_VERSION="4.52.5"

# Install base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        curl \
        ca-certificates \
        tar \
        tzdata \
        jq \
        git \
        nodejs \
        npm \
    && rm -rf /var/lib/apt/lists/*

# Install agent-browser (browser automation CLI — connects to browserless_chrome addon via CDP)
RUN npm install -g agent-browser@${AGENT_BROWSER_VERSION} --omit=dev && npm cache clean --force

# Download and extract ZeroClaw pre-built binary (glibc, compatible with Debian base)
RUN case "${BUILD_ARCH}" in \
      aarch64) ARCH="aarch64-unknown-linux-gnu" ;; \
      amd64)   ARCH="x86_64-unknown-linux-gnu" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL \
      "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${ZEROCLAW_VERSION}/zeroclaw-${ARCH}.tar.gz" \
      | tar -xz -C /usr/local/bin zeroclaw && \
    chmod +x /usr/local/bin/zeroclaw

# Download ttyd binary (not in Debian repos)
RUN case "${BUILD_ARCH}" in \
      aarch64) TTYD_ARCH="aarch64" ;; \
      amd64)   TTYD_ARCH="x86_64" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL \
      "https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.${TTYD_ARCH}" \
      -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

# Download yq for surgical TOML manipulation (manage [[mcp.servers]] by name)
RUN case "${BUILD_ARCH}" in \
      aarch64) YQ_ARCH="arm64" ;; \
      amd64)   YQ_ARCH="amd64" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL \
      "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/yq_linux_${YQ_ARCH}" \
      -o /usr/local/bin/yq && \
    chmod +x /usr/local/bin/yq

# Cache-bust: increment when rootfs scripts change to force layer rebuild
ARG ROOTFS_VERSION=16
# Copy S6-overlay services and scripts
COPY rootfs /

# Ensure S6 run/finish scripts are executable regardless of git permissions
RUN chmod +x \
    /etc/s6-overlay/s6-rc.d/zeroclaw/run \
    /etc/s6-overlay/s6-rc.d/zeroclaw/finish \
    /etc/s6-overlay/s6-rc.d/ttyd/run \
    /etc/s6-overlay/s6-rc.d/ttyd/finish
