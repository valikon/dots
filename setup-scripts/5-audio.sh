#!/usr/bin/env bash

echo
echo "INSTALLING AUDIO COMPONENTS"
echo

PKGS=(
            'alsa-utils'        # Advanced Linux Sound Architecture (ALSA) Components https://alsa.opensrc.org/
            'alsa-plugins'      # ALSA plugins
            'pipewire'          # Low-latency audio/video router and processor
            'pipewire-alsa'     # ALSA configuration for Pipewire
            'pipewire-pulse'    # PulseAudio replacement
            'playerctl'         # Player controller
            'pavucontrol'       # Pulse Audio volume control
            'volumeicon'        # System tray volume control
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo
echo "Done!"
echo
