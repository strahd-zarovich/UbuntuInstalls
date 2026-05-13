#!/usr/bin/env bash
set -euo pipefail

echo "Disabling cloud-init..."
sudo touch /etc/cloud/cloud-init.disabled
sudo apt-get purge cloud-init -y || true
sudo rm -rf /etc/cloud/ /var/lib/cloud/

echo "Installing qemu-guest-agent..."
sudo apt update
sudo apt install -y qemu-guest-agent
sudo systemctl enable --now qemu-guest-agent

echo "Setting timezone..."
sudo timedatectl set-timezone America/New_York

echo "Baseline complete."
echo "Run ./update.sh whenever you want to update this server."