#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "UbuntuInstalls"
echo
echo "1) Baseline server setup"
echo "2) Install basic tools"
echo "3) Install Docker"
echo "4) Install Glances"
echo "5) Update server"
echo "0) Exit"
echo

read -rp "Choose an option: " choice

case "$choice" in
  1) bash "$SCRIPT_DIR/scripts/baseline-update.sh" ;;
  2) bash "$SCRIPT_DIR/scripts/install-basic-tools.sh" ;;
  3) bash "$SCRIPT_DIR/scripts/install-docker.sh" ;;
  4) bash "$SCRIPT_DIR/scripts/install-glances.sh" ;;
  5) bash "$SCRIPT_DIR/scripts/update-server.sh" ;;
  0) exit 0 ;;
  *) echo "Invalid option"; exit 1 ;;
esac