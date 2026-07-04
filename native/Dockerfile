# ================================================================
#   Dockerfile — Egg PM2 by zakkixd (Multi-OS Base Support)
#   OS: Ubuntu / Debian Base
#   Runtimes: Node.js (v16-v24 NVM), Bun, Python3, PHP (with FPM)
#   Services: Nginx (Web Server)
#   System Deps: Canvas (Cairo, Pango, RSVG), FFmpeg, Python, etc.
#   Tools: Cloudflared, Speedtest CLI, Fastfetch, Git, etc.
#   Developer: zakkixd
# ================================================================

# Nilai default jika build-arg tidak ditentukan
ARG BASE_IMAGE=ubuntu:26.04
FROM ${BASE_IMAGE}

# Build-time metadata
ARG IMAGE_VERSION=5.0.0
ARG IMAGE_REVISION=latest
ARG IMAGE_CREATED=unknown

# Labels
LABEL author="zakkixd" \
      maintainer="zakkixd" \
      description="Egg PM2 Premium AIO by zakkixd — Node.js, Bun, Python3, PHP, Nginx, Canvas Deps, FFmpeg, Cloudflared, Speedtest, and Fastfetch" \
      org.opencontainers.image.title="Egg PM2 Premium by zakkixd" \
      org.opencontainers.image.version="${IMAGE_VERSION}" \
      org.opencontainers.image.authors="zakkixd" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.revision="${IMAGE_REVISION}"

# Environment
ENV IMAGE_VERSION=${IMAGE_VERSION} \
    IMAGE_REVISION=${IMAGE_REVISION} \
    IMAGE_CREATED=${IMAGE_CREATED} \
    HOME=/home/container \
    NVM_DIR=/home/container/.nvm \
    DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Jakarta

# Install system dependencies (Kompatibel untuk Ubuntu & Debian)
# Ditambahkan Nginx & PHP beserta extension populer
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    wget \
    git \
    tar \
    zip \
    unzip \
    ca-certificates \
    gnupg \
    lsb-release \
    procps \
    iproute2 \
    build-essential \
    python3 \
    python3-pip \
    python3-dev \
    ffmpeg \
    tzdata \
    neofetch \
    jq \
    libcairo2-dev \
    libpango1.0-dev \
    libjpeg-dev \
    libgif-dev \
    librsvg2-dev \
    libpixman-1-dev \
    nginx \
    php-cli \
    php-fpm \
    php-common \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-zip \
    php-sqlite3 \
    php-mysql \
    && rm -rf /var/lib/apt/lists/*

# Install Bun (Globally accessible)
RUN env HOME=/root curl -fsSL https://bun.sh/install | bash && \
    mv /root/.bun/bin/bun /usr/local/bin/bun && \
    rm -rf /root/.bun

# Install Official Speedtest CLI (Ookla)
RUN curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash && \
    apt-get install -y speedtest && \
    rm -rf /var/lib/apt/lists/*

# Install Cloudflared Tunnel
RUN curl -L --output /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod +x /usr/local/bin/cloudflared

# Install Fastfetch
RUN wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.tar.gz && \
    tar -zxf fastfetch-linux-amd64.tar.gz && \
    mv fastfetch-linux-amd64/usr/bin/fastfetch /usr/local/bin/fastfetch && \
    rm -rf fastfetch-linux-amd64*

# Buat user container (Pterodactyl style)
RUN useradd -m -d /home/container -s /bin/bash container

# Konfigurasi agar Nginx bisa dijalankan oleh user biasa (tanpa root)
# Buat folder temporary cache & log nginx di tempat yang bisa ditulis oleh user container
RUN mkdir -p /var/lib/nginx/body /var/lib/nginx/fastcgi /var/lib/nginx/proxy /var/lib/nginx/scgi /var/lib/nginx/uwsgi /var/log/nginx /var/run /run/php && \
    chown -R container:container /var/lib/nginx /var/log/nginx /var/run /run/php

# Install NVM sebagai user container + pre-install Node.js versi populer
USER container
WORKDIR /home/container

RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash && \
    export NVM_DIR="/home/container/.nvm" && \
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && \
    # Pre-install versi Node.js
    nvm install 16 && \
    nvm install 18 && \
    nvm install 20 && \
    nvm install 22 && \
    nvm install 24 && \
    nvm alias default 24 && \
    # Install/update npm & pm2 terbaru untuk semua versi Node.js
    for ver in 16 18 20 22 24 default; do \
        nvm use $ver && \
        npm install -g npm@latest pm2@latest; \
    done && \
    nvm use default && \
    # Bersihkan cache
    npm cache clean --force

# Copy entrypoint
USER root
COPY --chown=container:container ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER container

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
CMD ["/bin/bash"]
