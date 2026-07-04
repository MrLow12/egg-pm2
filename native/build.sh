#!/bin/bash
# ================================================================
#   Build Script — Egg PM2 by zakkixd (Multi-OS Support)
#   Builds and pushes Docker images to GitHub Container Registry
# ================================================================

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
NC='\033[0m'

# Konfigurasi
GITHUB_USERNAME="MrLow12"
IMAGE_NAME="egg-pm2"
REGISTRY="ghcr.io"

IMAGE_VERSION="3.5.0"
IMAGE_REVISION=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
IMAGE_CREATED=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

clear
echo -e "${CYAN}"
echo "  ███████╗ █████╗ ██╗  ██╗██╗  ██╗██╗██╗  ██╗██████╗ "
echo "  ╚══███╔╝██╔══██╗██║ ██╔╝██║ ██╔╝██║╚██╗██╔╝██╔══██╗"
echo "    ███╔╝ ███████║█████╔╝ █████╔╝ ██║ ╚███╔╝ ██║  ██║"
echo "   ███╔╝  ██╔══██║██╔═██╗ ██╔═██╗ ██║ ██╔██╗ ██║  ██║"
echo "  ███████╗██║  ██║██║  ██╗██║  ██╗██║██╔╝ ██╗██████╔╝"
echo "  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ "
echo -e "${NC}"
echo -e "${MAGENTA}[ Build Script — Egg PM2 by zakkixd ]${NC}"
echo ""

echo "Pilih OS Base yang ingin di-build:"
echo "1) Ubuntu 26.04 LTS (ubuntu26)"
echo "2) Ubuntu 24.04 LTS (ubuntu24)"
echo "3) Ubuntu 22.04 LTS (ubuntu22)"
echo "4) Debian 12 Bookworm (debian12)"
echo "5) Debian 11 Bullseye (debian11)"
echo "6) Build SEMUA Versi"
read -p "Masukkan pilihan (1-6): " PILIHAN

case $PILIHAN in
    1)
        BASES=("ubuntu:26.04")
        TAGS=("ubuntu26")
        ;;
    2)
        BASES=("ubuntu:24.04")
        TAGS=("ubuntu24")
        ;;
    3)
        BASES=("ubuntu:22.04")
        TAGS=("ubuntu22")
        ;;
    4)
        BASES=("debian:12-slim")
        TAGS=("debian12")
        ;;
    5)
        BASES=("debian:11-slim")
        TAGS=("debian11")
        ;;
    6)
        BASES=("ubuntu:26.04" "ubuntu:24.04" "ubuntu:22.04" "debian:12-slim" "debian:11-slim")
        TAGS=("ubuntu26" "ubuntu24" "ubuntu22" "debian12" "debian11")
        ;;
    *)
        echo -e "${RED}Pilihan tidak valid!${NC}"
        exit 1
        ;;
esac

for i in "${!BASES[@]}"; do
    BASE="${BASES[$i]}"
    TAG="${TAGS[$i]}"
    FULL_IMAGE="${REGISTRY}/${GITHUB_USERNAME}/${IMAGE_NAME}:${TAG}"
    
    echo -e "${YELLOW}🔨 Building image [${TAG}] dari base [${BASE}]...${NC}"
    
    docker build \
        --build-arg BASE_IMAGE="${BASE}" \
        --build-arg IMAGE_VERSION="${IMAGE_VERSION}" \
        --build-arg IMAGE_REVISION="${IMAGE_REVISION}" \
        --build-arg IMAGE_CREATED="${IMAGE_CREATED}" \
        -t "${FULL_IMAGE}" \
        .

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Build [${TAG}] sukses! Pushing to registry...${NC}"
        docker push "${FULL_IMAGE}"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ Image [${TAG}] berhasil di-push!${NC}"
        else
            echo -e "${RED}✗ Gagal push image [${TAG}]. Pastikan sudah login via 'docker login ghcr.io'${NC}"
        fi
    else
        echo -e "${RED}✗ Build [${TAG}] gagal!${NC}"
    fi
    echo "--------------------------------------------------"
done
