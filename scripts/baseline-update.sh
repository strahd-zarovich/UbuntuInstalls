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

echo "Creating standard update.sh..."
cat <<'EOF' | sudo tee /usr/local/bin/update-server
#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo reboot
EOF

sudo chmod +x /usr/local/bin/update-server

echo "Baseline complete."
echo "You can now run: update-server"