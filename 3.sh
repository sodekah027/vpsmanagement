#!/bin/bash

# Cek root
if [[ $EUID -ne 0 ]]; then
    echo "Harus dijalankan sebagai root!"
    exit 1
fi

# Dependency minimal
if ! command -v curl &>/dev/null; then
    echo "Installing curl..."
    apt update && apt install -y curl
fi

clear
echo "-----------------------------------"
echo "        VPS Management Menu        "
echo "-----------------------------------"
echo "1. Install Script"
echo "2. Reinstall"
echo "3. Routing"
echo "4. Install Gotop"
echo "5. Theme Marzban Subscription"
echo "6. Install Swap File RAM"
echo "7. Install Index.html"
echo "8. Backup Database db.sqlite3"
echo "-----------------------------------"

read -rp "Pilih opsi (1-8): " choice

case "$choice" in
    1)
        echo "Installing script..."
        curl -fsSL https://raw.githubusercontent.com/GawrAme/MarLing/main/mar.sh -o mar.sh \
        && chmod +x mar.sh \
        && ./mar.sh
        ;;
    2)
        echo "Reinstalling system..."
        curl -fsSL https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh -o reinstall.sh \
        && bash reinstall.sh debian 12 \
        && reboot
        ;;
    3)
        echo "Running routing script..."
        curl -fsSL https://raw.githubusercontent.com/sodekah027/rutehtml/refs/heads/main/menu-routing1.sh -o menu-routing1.sh \
        && chmod +x menu-routing1.sh \
        && ./menu-routing1.sh
        ;;
    4)
        echo "Installing Gotop..."
        curl -fsSL https://github.com/sodekah027/gotop/raw/refs/heads/main/gotop -o /usr/local/bin/gotop \
        && chmod +x /usr/local/bin/gotop
        ;;
    5)
        echo "Changing Marzban subscription theme..."
        curl -fsSL https://raw.githubusercontent.com/sodekah027/marzban-subscription/refs/heads/main/index.html \
        -o /var/lib/marzban/templates/subscription/index.html
        ;;
    6)
        echo "Installing Swap File RAM (2G)..."
        swapoff -a
        fallocate -l 2G /swapfile
        chmod 600 /swapfile
        mkswap /swapfile
        swapon /swapfile
        grep -q "/swapfile" /etc/fstab || echo "/swapfile none swap sw 0 0" >> /etc/fstab
        swapon --show
        free -h
        ;;
    7)
        echo "Installing Index.html..."
        curl -fsSL https://raw.githubusercontent.com/sodekah027/panel-information/refs/heads/main/index.html \
        -o /var/www/html/index.html
        ;;
    8)
        echo "Backing up database db.sqlite3..."
        curl -fsSL https://raw.githubusercontent.com/sodekah027/backup-pribadi/refs/heads/main/tele.sh -o tele.sh \
        && chmod +x tele.sh \
        && ./tele.sh \
        && clear
        ;;
    *)
        echo "Opsi tidak valid!"
        ;;
esac

