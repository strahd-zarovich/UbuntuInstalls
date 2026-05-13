#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME="$(eval echo "~$CURRENT_USER")"

echo "======================================"
echo " Baseline Server Setup"
echo "======================================"

echo "Adding $CURRENT_USER to sudo group..."
sudo usermod -aG sudo "$CURRENT_USER"

echo "Disabling cloud-init..."

if [ -d /etc/cloud ]; then
    sudo touch /etc/cloud/cloud-init.disabled
else
    echo "/etc/cloud does not exist. Skipping cloud-init disable file."
fi

sudo apt-get purge cloud-init -y || true
sudo rm -rf /etc/cloud/ /var/lib/cloud/ || true

echo "Installing qemu-guest-agent if supported..."
sudo apt update
sudo apt install -y qemu-guest-agent || echo "qemu-guest-agent install skipped or not supported."
sudo systemctl restart qemu-guest-agent 2>/dev/null || echo "qemu-guest-agent service not active or not needed."

echo "Setting timezone..."
sudo timedatectl set-timezone America/New_York

echo "Copying update.sh to $USER_HOME..."
sudo cp "$REPO_DIR/update.sh" "$USER_HOME/update.sh"
sudo chown "$CURRENT_USER:$CURRENT_USER" "$USER_HOME/update.sh"
sudo chmod +x "$USER_HOME/update.sh"

echo
echo "Baseline complete."
echo "update.sh is now available at:"
echo "$USER_HOME/update.sh"