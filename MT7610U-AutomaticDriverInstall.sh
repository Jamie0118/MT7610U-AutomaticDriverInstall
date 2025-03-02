#!/bin/bash

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root. Use 'sudo' before this script."
        exit 1
    fi
}

check_distribution() {
    if [[ -f /etc/debian_version ]]; then
        PACKAGE_MANAGER="apt-get"
    elif [[ -f /etc/redhat-release ]]; then
        PACKAGE_MANAGER="dnf"
    else
        echo "Unsupported Linux distribution. Exiting!"
        exit 1
    fi
}

check_secure_boot() {
    SECURE_BOOT_STATUS=$(mokutil --sb-state 2>/dev/null)
    if [[ $SECURE_BOOT_STATUS == *"enabled"* ]]; then
        SECURE_BOOT_ENABLED=true
        echo "Secure Boot is ENABLED. Module signing may be required."
    else
        SECURE_BOOT_ENABLED=false
        echo "Secure Boot is DISABLED. Module signing will be skipped."
    fi
}

install_required_packages() {
    if ! command -v git &> /dev/null; then
        echo "Installing required packages..."
        sudo "$PACKAGE_MANAGER" install git build-essential linux-headers-$(uname -r) -y
    fi
}

update_system() {
    echo "Setting DEBIAN_FRONTEND to noninteractive for updates."
    export DEBIAN_FRONTEND=noninteractive

    echo "Installing updates and upgrades. This may take some time..."
    sudo "$PACKAGE_MANAGER" update -y && \
    sudo "$PACKAGE_MANAGER" upgrade -y && \
    sudo "$PACKAGE_MANAGER" dist-upgrade -y
}

install_drivers() {
    echo "Installing drivers"

    echo "Cloning the repository..."
    git clone https://github.com/rebrane/mt7610u || { echo "Git clone failed! Exiting."; exit 1; }

    echo "Changing to the driver directory..."
    cd mt7610u || { echo "Failed to change directory. Exiting."; exit 1; }

    echo "Compiling the driver..."
    sudo make || { echo "Compilation failed! Exiting."; exit 1; }

    echo "Installing the driver..."
    sudo make install || { echo "Installation failed! Exiting."; exit 1; }

    if [[ "$SECURE_BOOT_ENABLED" == true ]]; then
        echo "Secure Boot is enabled. Attempting to sign the module..."
        sudo mokutil --import MOK.der
    else
        echo "Secure Boot is disabled. Skipping module signing."
    fi
}

check_root
check_distribution
check_secure_boot
update_system
install_required_packages
install_drivers

echo "Installation complete!"
read -p "Do you want to reboot now? (y/n): " REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" =~ ^[Yy]$ ]]; then
    echo "Rebooting now..."
    reboot
else
    echo "Remember to restart your system for the changes to take effect."
fi
