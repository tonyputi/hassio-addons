ARG BUILD_FROM
FROM ${BUILD_FROM}

ARG BUILD_ARCH
ARG PICOCLAW_VERSION="0.2.4"

# Install base dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        curl \
        ca-certificates \
        tar \
        tzdata \
        jq \
    && rm -rf /var/lib/apt/lists/*

# Download and extract PicoClaw binaries (gateway + web launcher)
RUN case "${BUILD_ARCH}" in \
      aarch64) ARCH="arm64" ;; \
      amd64)   ARCH="x86_64" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL \
      "https://github.com/sipeed/picoclaw/releases/download/v${PICOCLAW_VERSION}/picoclaw_Linux_${ARCH}.tar.gz" \
      | tar -xz -C /usr/local/bin picoclaw picoclaw-launcher && \
    chmod +x /usr/local/bin/picoclaw /usr/local/bin/picoclaw-launcher

# Cache-bust: increment when rootfs scripts change to force layer rebuild
ARG ROOTFS_VERSION=3
COPY rootfs /

RUN chmod +x \
    /etc/s6-overlay/s6-rc.d/picoclaw/run \
    /etc/s6-overlay/s6-rc.d/picoclaw/finish \
    /etc/s6-overlay/s6-rc.d/picoclaw-launcher/run \
    /etc/s6-overlay/s6-rc.d/picoclaw-launcher/finish
