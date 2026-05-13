#!/usr/bin/env bash
set -euo pipefail

echo "Installing Glances Web Server..."

sudo systemctl stop glances 2>/dev/null || true
sudo systemctl disable glances 2>/dev/null || true

sudo apt update
sudo apt remove glances -y 2>/dev/null || true
sudo apt install -y python3-venv python3-pip

sudo rm -rf /opt/glances-venv
sudo python3 -m venv /opt/glances-venv
sudo /opt/glances-venv/bin/pip install --upgrade pip
sudo /opt/glances-venv/bin/pip install "glances[web,docker]"

sudo tee /etc/systemd/system/glances.service >/dev/null <<'EOF'
[Unit]
Description=Glances Web Server
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/opt/glances-venv/bin/glances -w --bind 0.0.0.0 --port 61208
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now glances

echo "Glances installed."
sudo systemctl status glances --no-pager
