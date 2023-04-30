#!/usr/bin/env bash
echo
echo "INSTALLING WM tools"
echo

PKGS=(
    'trayer'
    'xmobar'
)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

echo
echo "Done!"
echo
