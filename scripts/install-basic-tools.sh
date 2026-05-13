#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y \
  curl \
  wget \
  git \
  nano \
  htop \
  btop \
  ncdu \
  unzip \
  zip \
  jq \
  net-tools \
  dnsutils \
  ca-certificates \
  gnupg \
  lsb-release

echo "Basic tools installed."
