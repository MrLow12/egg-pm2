# 🚀 Pterodactyl Egg PM2 — Premium AIO (Ubuntu & Debian)

**Koleksi Egg Pterodactyl premium untuk menjalankan Node.js (PM2), Bun, Python3, PHP, Nginx, dan sistem operasi Linux lengkap dengan akses root.**

Developer: **zakkixd**

---

## 📦 Pilihan Egg yang Tersedia

Repository ini menyediakan 2 jenis Egg Pterodactyl yang bisa kamu pilih sesuai dengan kebutuhan server kamu:

### 1️⃣ Egg PM2 (Native Multi-OS)
Egg yang berjalan langsung di atas container Docker native (Ubuntu 22/24/26 & Debian 11/12).
*   ⚡ **Performa 100% Maksimal** — Tanpa emulasi, sangat ringan dan cepat.
*   💾 **Hemat Penyimpanan (0 GB)** — File OS tidak menggunakan kuota penyimpanan server Pterodactyl kamu.
*   🟢 **Runtimes Lengkap** — Node.js (NVM), Bun, Python3, PHP-FPM, Nginx, Speedtest, Cloudflared Tunnel, FFmpeg, dan dependensi Canvas.

### 2️⃣ Egg PM2 (Linux System with Root Access)
Egg dengan sistem Linux virtual di mana kamu diberikan **akses root simulasi penuh**.
*   🔑 **Akses Root (`apt-get install`)** — Kamu bebas menginstal paket software apa saja langsung dari terminal console server menggunakan perintah `apt`.
*   📦 **Multi-OS Dropdown** — Pilih Ubuntu 24.04, Ubuntu 22.04, Debian 12, atau Debian 11 saat pertama kali server dinyalakan.
*   🟢 **Pre-installed** — Otomatis dibekali Node.js (v16 s/d v24 via NVM), Bun, Python3, PHP, Nginx, Speedtest, dan Cloudflared Tunnel.

---

## 🎨 Preview Tampilan Console saat Server Dinyalakan

Setiap kali server dinyalakan, console panel akan menampilkan informasi hardware, penggunaan resource, dan versi runtime secara real-time:

```
  ███████╗ █████╗ ██╗  ██╗██╗  ██╗██╗██╗  ██╗██████╗ 
  ╚══███╔╝██╔══██╗██║ ██╔╝██║ ██╔╝██║╚██╗██╔╝██╔══██╗
    ███╔╝ ███████║█████╔╝ █████╔╝ ██║ ╚███╔╝ ██║  ██║
   ███╔╝  ██╔══██║██╔═██╗ ██╔═██╗ ██║ ██╔██╗ ██║  ██║
  ███████╗██║  ██║██║  ██╗██║  ██╗██║██╔╝ ██╗██████╔╝
  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ 

╔══════════════════════════════════════════════════════════╗
║        ⚡ EGG PM2 ROOT — Developed by zakkixd ⚡         ║
║        Node.js Process Manager with Root Access          ║
║        https://github.com/zakkixd                        ║
╚══════════════════════════════════════════════════════════╝

⚙  Memilih Node.js version: v24...

📊 System Specs (Fastfetch):
  _____
 /  __ \    root@zakkixd
|  /    |  ------------
|  \___-    OS: Ubuntu 24.04 LTS (Noble) x86_64
-_          Kernel: Linux 6.15.0-generic
  --_       Uptime: 1 hour, 15 mins
            CPU: AMD Ryzen (4 Cores)
            Memory: 1.10 GiB / 8.00 GiB (13%)

┌────────────────────────────────────────────────────────┐
│  🖥  Detailed Hardware Info & Networking              │
├────────────────────────────────────────────────────────┤
│  OS       : Ubuntu 24.04 LTS (Noble)
│  IP Addr  : 103.152.124.90
│  CPU Model: AMD EPYC Processor (4 Cores)
│  RAM Usage: 1120MB / 8192MB
│  Disk Space: 52G free / 80G total
│  System Up: 1 hour, 15 minutes
├────────────────────────────────────────────────────────┤
│  📦 Installed Extra Modules                           │
├────────────────────────────────────────────────────────┤
│  Speedtest: Installed (Ketik 'speedtest' untuk tes koneksi)
│  Cloudflare: Installed (Ketik 'cloudflared' untuk setup tunnel)
├────────────────────────────────────────────────────────┤
│  🟢 Active Runtimes & Servers                         │
├────────────────────────────────────────────────────────┤
│  Node.js  : v24.0.0 (PM2 v5.4.2, NPM v10.8.1)
│  Bun      : v1.1.20 (Latest)
│  Python3  : v3.12.3
│  PHP      : v8.3.8
│  Nginx    : v1.26.0
└────────────────────────────────────────────────────────┘

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Developer : zakkixd
  Powered by: Node.js + PM2 (Dynamic version via NVM)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 Starting your application...
```

---

## 🛠 Cara Memasang di Pterodactyl

1.  Masuk ke **Admin Panel Pterodactyl** kamu.
2.  Buka menu **Nests** -> klik **Eggs** -> klik tombol **Import Egg**.
3.  Upload file konfigurasi `.json` yang kamu butuhkan:
    *   **Native**: [egg-zakkixd-pm2.json](egg-zakkixd-pm2.json)
    *   **Linux System with Root**: [egg-zakkixd-vps-pm2.json](egg-zakkixd-vps-pm2.json)
4.  Gunakan Docker Image yang sesuai pada pengaturan server:
    *   Native OS: `ghcr.io/mrlow12/egg-pm2:ubuntu26` (atau tag os lain)
    *   Linux System with Root: `ghcr.io/mrlow12/egg-pm2-proot:latest`

---

## 👨‍💻 Credits & Developer
*   Developed by **zakkixd**
