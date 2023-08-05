#!/bin/bash

# Check if running with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Delete enterprise repo
rm -f /etc/apt/sources.list.d/pve-enterprise.list

# Add 7.x repo into update list
echo "deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" >> /etc/apt/sources.list.d/pve-install-repo.list

# Get release key
wget -q http://download.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg

# Update & Upgrade
apt update && apt dist-upgrade -y

# Check if apt commands were successful
if [ $? -eq 0 ]; then
    echo "Update and upgrade completed successfully."
else
    echo "Update or upgrade encountered an error."
fi

