ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH
ARG ZEROCLAW_VERSION="0.6.5"

# Install dependencies
RUN apk add --no-cache curl ca-certificates

# Download pre-built ZeroClaw binary for the target arch
RUN case "${BUILD_ARCH}" in \
      aarch64) ARCH="aarch64-unknown-linux-musl" ;; \
      amd64)   ARCH="x86_64-unknown-linux-musl" ;; \
      *) echo "Unsupported arch: ${BUILD_ARCH}" && exit 1 ;; \
    esac && \
    curl -fsSL \
      "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v${ZEROCLAW_VERSION}/zeroclaw-${ARCH}" \
      -o /usr/local/bin/zeroclaw && \
    chmod +x /usr/local/bin/zeroclaw

# Copy S6-overlay services and scripts
COPY rootfs /
