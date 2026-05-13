#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(eval echo "~$CURRENT_USER")"

echo "======================================"
echo " Baseline Server Setup"
echo "======================================"

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

echo "Copying update.sh to $USER_HOME..."
cp "$REPO_DIR/update.sh" "$USER_HOME/update.sh"
chmod +x "$USER_HOME/update.sh"

echo
echo "Baseline complete."
echo "update.sh is now available at:"
echo "$USER_HOME/update.sh"