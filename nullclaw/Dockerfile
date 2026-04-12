ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG NULLCLAW_VERSION="2026.4.9"

# Install base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        curl \
        ca-certificates \
        tar \
        tzdata \
        jq \
    && rm -rf /var/lib/apt/lists/*

# Download NullClaw pre-built binary
RUN case "${BUILD_ARCH}" in \
      aarch64) ARCH="aarch64" ;; \
      amd64)   ARCH="x86_64" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL \
      "https://github.com/nullclaw/nullclaw/releases/download/v${NULLCLAW_VERSION}/nullclaw-linux-${ARCH}.bin" \
      -o /usr/local/bin/nullclaw && \
    chmod +x /usr/local/bin/nullclaw

# Download ttyd binary (consistent with ZeroClaw/PicoClaw/OpenClaw pattern)
RUN case "${BUILD_ARCH}" in \
      aarch64) TTYD_ARCH="aarch64" ;; \
      amd64)   TTYD_ARCH="x86_64" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL \
      "https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.${TTYD_ARCH}" \
      -o /usr/local/bin/ttyd && \
    chmod +x /usr/local/bin/ttyd

# Cache-bust: increment when rootfs scripts change to force layer rebuild
ARG ROOTFS_VERSION=1
COPY rootfs /

RUN chmod +x \
    /etc/s6-overlay/s6-rc.d/nullclaw/run \
    /etc/s6-overlay/s6-rc.d/nullclaw/finish \
    /etc/s6-overlay/s6-rc.d/ttyd/run \
    /etc/s6-overlay/s6-rc.d/ttyd/finish
