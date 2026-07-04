#!/bin/bash

# ================================================================
#   EGG PM2 by zakkixd (AIO Feature Console)
#   Developer: zakkixd
#   GitHub: https://github.com/zakkixd
# ================================================================

# Warna Terminal
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Clear terminal
clear

# ================================================================
# ASCII Art Banner - zakkixd
# ================================================================
echo -e "${CYAN}"
echo "  ███████╗ █████╗ ██╗  ██╗██╗  ██╗██╗██╗  ██╗██████╗ "
echo "  ╚══███╔╝██╔══██╗██║ ██╔╝██║ ██╔╝██║╚██╗██╔╝██╔══██╗"
echo "    ███╔╝ ███████║█████╔╝ █████╔╝ ██║ ╚███╔╝ ██║  ██║"
echo "   ███╔╝  ██╔══██║██╔═██╗ ██╔═██╗ ██║ ██╔██╗ ██║  ██║"
echo "  ███████╗██║  ██║██║  ██╗██║  ██╗██║██╔╝ ██╗██████╔╝"
echo "  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ "
echo -e "${NC}"

echo -e "${MAGENTA}╔══════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║${NC}        ${BOLD}${WHITE}⚡ EGG PM2 — Developed by zakkixd ⚡${NC}             ${MAGENTA}║${NC}"
echo -e "${MAGENTA}║${NC}        ${CYAN}Node.js Process Manager for Pterodactyl${NC}           ${MAGENTA}║${NC}"
echo -e "${MAGENTA}║${NC}        ${GRAY}https://github.com/zakkixd${NC}                        ${MAGENTA}║${NC}"
echo -e "${MAGENTA}╚══════════════════════════════════════════════════════════╝${NC}"
echo ""

# ================================================================
# Load NVM & Set Node.js Version
# ================================================================
export NVM_DIR="/home/container/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
    . "$NVM_DIR/nvm.sh"
else
    echo -e "${RED}[zakkixd] NVM tidak ditemukan! Menggunakan default system Node.js.${NC}"
fi

# Mengambil input Node.js version dari environment, default v24 jika kosong
WANTED_NODE_VERSION="${NODE_VERSION:-24}"

echo -e "${YELLOW}⚙  Memilih Node.js version: v${WANTED_NODE_VERSION}...${NC}"

# Cek apakah version sudah terinstall, jika belum install via NVM
if nvm ls "$WANTED_NODE_VERSION" >/dev/null 2>&1; then
    nvm use "$WANTED_NODE_VERSION" >/dev/null
else
    echo -e "${YELLOW}⚙  Node.js v${WANTED_NODE_VERSION} belum terinstall. Mengunduh dan menginstall...${NC}"
    nvm install "$WANTED_NODE_VERSION" >/dev/null
    nvm use "$WANTED_NODE_VERSION" >/dev/null
    # Pastikan PM2 terinstall di versi baru ini
    if ! command -v pm2 &> /dev/null; then
        echo -e "${YELLOW}⚙  Menginstall PM2 untuk Node.js v${WANTED_NODE_VERSION}...${NC}"
        npm install -g pm2 >/dev/null
    fi
fi

CURRENT_NODE_VER=$(node -v 2>/dev/null || echo "Unknown")
CURRENT_PM2_VER=$(pm2 -v 2>/dev/null || echo "Unknown")
CURRENT_NPM_VER=$(npm -v 2>/dev/null || echo "Unknown")
CURRENT_BUN_VER=$(bun --version 2>/dev/null || echo "Not Installed")
CURRENT_PYTHON_VER=$(python3 --version 2>/dev/null | awk '{print $2}' || echo "Not Installed")
CURRENT_PHP_VER=$(php -v 2>/dev/null | head -n 1 | awk '{print $2}' || echo "Not Installed")
CURRENT_NGINX_VER=$(nginx -v 2>&1 | awk -F/ '{print $2}' || echo "Not Installed")

# ================================================================
# Tampilkan Fastfetch
# ================================================================
if command -v fastfetch &> /dev/null; then
    echo -e "${CYAN}📊 System Specs (Fastfetch):${NC}"
    fastfetch --logo debian_small --color-keys cyan --color-title white
    echo ""
else
    if command -v neofetch &> /dev/null; then
        echo -e "${CYAN}📊 System Specs (Neofetch):${NC}"
        neofetch --stdout
        echo ""
    fi
fi

# ================================================================
# Informasi Tambahan Detail (IP, CPU, RAM, Disk, Port, Modules)
# ================================================================
OS=$(lsb_release -d 2>/dev/null | awk -F'\t' '{print $2}' || echo "Linux Distribution")
IP=$(hostname -I 2>/dev/null | awk '{print $1}' || echo "Unknown")
CPU=$(grep -m1 'model name' /proc/cpuinfo 2>/dev/null | awk -F': ' '{print $2}' || echo "Unknown")
CORES=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || echo "1")
RAM_USED=$(free -m 2>/dev/null | awk '/Mem:/ {print $3}')
RAM_TOTAL=$(free -m 2>/dev/null | awk '/Mem:/ {print $2}')
DISK=$(df -h / 2>/dev/null | awk 'NR==2 {print $4 " free / " $2 " total"}' || echo "Unknown")
UPTIME_VAL=$(uptime -p 2>/dev/null || echo "Unknown")

# Cek Modul Tambahan
SPEEDTEST_STATUS="${RED}Offline/Not Found${NC}"
if command -v speedtest &> /dev/null; then
    SPEEDTEST_STATUS="${GREEN}Installed (Ketik 'speedtest' untuk tes koneksi)${NC}"
fi

CLOUDFLARED_STATUS="${RED}Offline/Not Found${NC}"
if command -v cloudflared &> /dev/null; then
    CLOUDFLARED_STATUS="${GREEN}Installed (Ketik 'cloudflared' untuk setup tunnel)${NC}"
fi

echo -e "${CYAN}┌────────────────────────────────────────────────────────┐${NC}"
echo -e "${CYAN}│${NC}  ${BOLD}${YELLOW}🖥  Detailed Hardware Info & Networking${NC}              ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYAN}│${NC}  ${GREEN}OS       :${NC} $OS"
echo -e "${CYAN}│${NC}  ${GREEN}IP Addr  :${NC} $IP"
echo -e "${CYAN}│${NC}  ${GREEN}CPU Model:${NC} $CPU ($CORES Cores)"
echo -e "${CYAN}│${NC}  ${GREEN}RAM Usage:${NC} ${RAM_USED}MB / ${RAM_TOTAL}MB"
echo -e "${CYAN}│${NC}  ${GREEN}Disk Space:${NC} $DISK"
echo -e "${CYAN}│${NC}  ${GREEN}System Up:${NC} $UPTIME_VAL"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYAN}│${NC}  ${BOLD}${YELLOW}📦 Installed Extra Modules${NC}                           ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYAN}│${NC}  ${GREEN}Speedtest:${NC} $SPEEDTEST_STATUS"
echo -e "${CYAN}│${NC}  ${GREEN}Cloudflare:${NC} $CLOUDFLARED_STATUS"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYAN}│${NC}  ${BOLD}${YELLOW}🟢 Active Runtimes & Servers${NC}                           ${CYAN}│${NC}"
echo -e "${CYAN}├────────────────────────────────────────────────────────┤${NC}"
echo -e "${CYAN}│${NC}  ${GREEN}Node.js  :${NC} $CURRENT_NODE_VER (PM2 v$CURRENT_PM2_VER, NPM v$CURRENT_NPM_VER)"
echo -e "${CYAN}│${NC}  ${GREEN}Bun      :${NC} v$CURRENT_BUN_VER"
echo -e "${CYAN}│${NC}  ${GREEN}Python3  :${NC} v$CURRENT_PYTHON_VER"
echo -e "${CYAN}│${NC}  ${GREEN}PHP      :${NC} v$CURRENT_PHP_VER"
echo -e "${CYAN}│${NC}  ${GREEN}Nginx    :${NC} v$CURRENT_NGINX_VER"
echo -e "${CYAN}└────────────────────────────────────────────────────────┘${NC}"
echo ""

# ================================================================
# Developer Credit
# ================================================================
echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ${BOLD}${WHITE}Developer :${NC} ${CYAN}zakkixd${NC}"
echo -e "  ${BOLD}${WHITE}Powered by:${NC} ${GREEN}Node.js + PM2 (Dynamic version via NVM)${NC}"
echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

sleep 0.3
echo -e "${GREEN}🚀 Starting your application...${NC}"
echo ""

# Jalankan CMD yang diberikan oleh Pterodactyl
exec "$@"
