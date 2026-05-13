#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo " Ubuntu Server Setup"
echo "======================================"
echo "1) Install Glances"
echo "2) Install Docker"
echo "3) Install basic tools"
echo "4) Update server"
echo "5) Cleanup server"
echo "0) Exit"
echo

read -rp "Choose an option: " choice

case "$choice" in
  1) bash "$REPO_DIR/scripts/install-glances.sh" ;;
  2) bash "$REPO_DIR/scripts/install-docker.sh" ;;
  3) bash "$REPO_DIR/scripts/install-basic-tools.sh" ;;
  4) bash "$REPO_DIR/scripts/update-server.sh" ;;
  5) bash "$REPO_DIR/scripts/cleanup-server.sh" ;;
  0) exit 0 ;;
  *) echo "Invalid option"; exit 1 ;;
esac
