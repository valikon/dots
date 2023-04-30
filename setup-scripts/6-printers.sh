#!/usr/bin/env bash

echo
echo "INSTALLING PRINTER DRIVERS"
echo

PKGS=(
    'cups'                  # Open source printer drivers
    'cups-pdf'              # PDF support for cups
#    'ghostscript'           # PostScript interpreter
#    'gsfonts'               # Adobe Postscript replacement fonts
#    'hplip'                 # HP Drivers
#    'system-config-printer' # Printer setup  utility
)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

echo
echo "Done!"
echo
