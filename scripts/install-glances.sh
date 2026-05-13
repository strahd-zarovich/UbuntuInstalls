#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " Installing Glances Web Server"
echo "======================================"

echo "Stopping existing Glances service if present..."
sudo systemctl stop glances 2>/dev/null || true
sudo systemctl disable glances 2>/dev/null || true

echo "Installing dependencies..."
sudo apt update
sudo apt install -y \
    python3-venv \
    python3-pip \
    lm-sensors \
    python3-dev \
    gcc

echo "Removing old Glances virtual environment..."
sudo rm -rf /opt/glances-venv

echo "Creating Glances virtual environment..."
sudo python3 -m venv /opt/glances-venv

echo "Installing Glances with extra features..."
sudo /opt/glances-venv/bin/pip install --upgrade pip
sudo /opt/glances-venv/bin/pip install --upgrade \
    "glances[web,docker,gpu,snmp,graph,export]"

echo "Creating Glances systemd service..."
sudo tee /etc/systemd/system/glances.service >/dev/null <<'EOF'
[Unit]
Description=Glances Web Server
After=network-online.target docker.service
Wants=network-online.target

[Service]
ExecStart=/opt/glances-venv/bin/glances -w --bind 0.0.0.0 --port 61208
Restart=on-failure
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

echo "Starting Glances..."
sudo systemctl daemon-reload
sudo systemctl enable --now glances

echo
echo "Glances installed."
echo "Open in browser:"
echo "http://SERVER-IP:61208"
echo
sudo systemctl status glances --no-pager