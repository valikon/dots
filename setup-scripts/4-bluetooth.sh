#!/usr/bin/env bash

echo
echo "INSTALLING BLUETOOTH COMPONENTS"
echo

PKGS=(
        'bluez'                 # Daemons for the bluetooth protocol stack
        'bluez-utils'           # Bluetooth development and debugging utilities
#        'bluez-libs'            # possibly not needed anymore?
#        'blueberry'             # Bluetooth configuration tool
        'blueman'               # Bluetooth manager
# aur package       'bluez-firmware'        # Firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips
)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

echo
echo "Done!"
echo
