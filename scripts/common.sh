#!/usr/bin/env bash

require_root_or_sudo() {
  if ! command -v sudo >/dev/null 2>&1; then
    echo "sudo is required."
    exit 1
  fi
}

pause() {
  read -rp "Press Enter to continue..."
}
