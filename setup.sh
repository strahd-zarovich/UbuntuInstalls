#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

while true; do
    clear

    echo "======================================"
    echo " UbuntuInstalls"
    echo "======================================"
    echo
    echo "1) Baseline server setup"
    echo "2) Install basic tools"
    echo "3) Install Docker"
    echo "4) Install Glances"
    echo "5) Run update.sh"
    echo "8) Update UbuntuInstalls from GitHub"
    echo "9) Reboot server"
    echo "0) Exit"
    echo

    read -rp "Choose an option: " choice

    case "$choice" in
        1) bash "$SCRIPT_DIR/scripts/baseline-update.sh" ;;
        2) bash "$SCRIPT_DIR/scripts/install-basic-tools.sh" ;;
        3) bash "$SCRIPT_DIR/scripts/install-docker.sh" ;;
        4) bash "$SCRIPT_DIR/scripts/install-glances.sh" ;;
        5) bash "$SCRIPT_DIR/update.sh" ;;
        8)
            echo "Updating UbuntuInstalls from GitHub..."
            cd "$SCRIPT_DIR"
            git pull
            chmod +x setup.sh update.sh scripts/*.sh
            echo "UbuntuInstalls updated."
            ;;
        9)
            echo "Rebooting server..."
            sudo reboot
            ;;
        0)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac

    echo
    read -rp "Press Enter to return to the menu..."
done