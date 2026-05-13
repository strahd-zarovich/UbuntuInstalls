````markdown
# UbuntuInstalls

Personal Ubuntu/Debian server setup scripts used for quickly deploying and maintaining new servers.

These scripts are designed to simplify common server setup tasks including:
- Baseline Ubuntu configuration
- Docker installation
- Glances monitoring setup
- Common Linux administration tools
- Routine server updates

---

# Initial Usage

## Install Git

```bash
sudo apt update
sudo apt install -y git
````

## Clone Repository

```bash
git clone https://github.com/strahd-zarovich/UbuntuInstalls.git
```

## Enter Repository

```bash
cd UbuntuInstalls
```

## Make Scripts Executable

```bash
chmod +x setup.sh
chmod +x update.sh
chmod +x scripts/*.sh
```

## Launch Setup Menu

```bash
./setup.sh
```

---

# Daily Usage

Run server updates:

```bash
./update.sh
```

---

# File Overview

## setup.sh

Main launcher script for the repository.

Provides a simple menu interface for running the various setup and install scripts included in the project.

---

## update.sh

Runs Ubuntu package updates, upgrades, cleanup, and optional Pi-hole updates.

At completion, the script prompts for an optional reboot instead of automatically restarting the server.

---

# Scripts Folder

## scripts/baseline-update.sh

Performs the standard baseline configuration used on most new Ubuntu servers.

Disables cloud-init, installs qemu-guest-agent, and configures the server timezone.

---

## scripts/install-basic-tools.sh

Installs commonly used Linux administration and troubleshooting utilities.

Includes packages such as:

* curl
* wget
* git
* htop
* btop
* jq
* ncdu
* dnsutils
* unzip
* net-tools

---

## scripts/install-docker.sh

Installs Docker Engine and related Docker components from Docker’s official repository.

Also configures the current user for Docker group access.

---

## scripts/install-glances.sh

Installs Glances inside a Python virtual environment and configures it as a systemd web service.

Provides browser-based server monitoring on port 61208.

---

# Notes

* Scripts are intended for Ubuntu/Debian-based systems.
* Some actions may require logout/login before permissions apply.
* Review scripts before running them on production systems.
* Pi-hole updates inside `update.sh` are disabled by default and can be enabled manually if needed.

---

# Example Workflow

Typical new server setup process:

```bash
./setup.sh
```

Recommended order:

1. Baseline server setup
2. Install basic tools
3. Install Docker (if needed)
4. Install Glances (if needed)

Later maintenance:

```bash
./update.sh
```