#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " Starting Server Update"
echo "======================================"

sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

# Uncomment this only on Pi-hole servers.
# pihole -up

echo
echo "======================================"
echo " Update Complete"
echo "======================================"
echo

read -rp "Reboot now? [y/N]: " reboot_choice

if [[ "$reboot_choice" =~ ^[Yy]$ ]]; then
    sudo reboot
else
    echo "Reboot skipped."
fi