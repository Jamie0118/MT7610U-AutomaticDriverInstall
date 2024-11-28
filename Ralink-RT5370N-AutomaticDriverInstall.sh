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
        echo "Unsupported Linux distribution. bye!"
        exit 1
    fi
}

install_required_packages() {
    if ! command -v git &> /dev/null; then
        echo "git is not installed. Installing..."
        sudo "$PACKAGE_MANAGER" install git -y
        sudo "$PACKAGE_MANAGER" install build-essential -headers -y
    fi
}

update_system() {
    echo "Setting DEBIAN_FRONTEND to noninteractive for updates."
    export DEBIAN_FRONTEND=noninteractive

    echo "Installing updates and upgrades. Give it some time."
    sudo "$PACKAGE_MANAGER" update -y && \
    sudo "$PACKAGE_MANAGER" upgrade -y && \
    sudo "$PACKAGE_MANAGER" dist-upgrade -y
}

install_drivers() {
        echo "Installing drivers"

        echo "Cloning the repository..."
        git clone https://github.com/rebrane/mt7610u

        echo "Changing to the driver directory..."
        cd mt7610u-master || { echo "Failed to change directory. Exiting."; exit 1; }

        echo "Compiling the driver..."
        sudo make

        echo "Taking newly created binaries and copying them into the appropriate locations on the file system."
        sudo make install
        if [[ $? -ne 0 ]]; then
            echo "Installation of the driver binaries failed. Exiting."
            exit 1
        fi

}

check_root
check_distribution
update_system
install_required_packages
install_drivers

echo "Install complete!"
read -p "Do you want to reboot now? (y/n): " REBOOT_CHOICE
if [[ "$REBOOT_CHOICE" == "Y" || "$REBOOT_CHOICE" == "y" ]]; then
    echo "Rebooting!"
    reboot

else
    echo "Remember to restart"
    fi