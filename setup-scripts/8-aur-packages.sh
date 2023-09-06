#!/usr/bin/env bash

echo
echo "INSTALLING ESSENTIAL AUR PACKAGES"
echo

PKGS=(

    # RICE ----------------------------------------------------------------

    'sddm-sugar-dark'           # sddm theme
    'shell-color-scripts'       # DTs colorscripts

    # SYSTEM UTILITIES ----------------------------------------------------

#    'gtkhash'                   # Checksum verifier

    # TERMINAL UTILITIES --------------------------------------------------

#    'bitwarden-cli'              # Password manager CLI client
#    'aura-bin'                   # AUR package manager
    'aws-cli-v2'             # cli v2 for AWS
    'skroll'                     # text scroller

    # GENERAL UTILITIES ---------------------------------------------------

    'bitwarden'                  # Password manager
    'yad'                        # graphical dialogs from shell scripts or cli
#    'samba'                      # Samba File Sharing
#    'autofs'                     # Auto-mounter

    # DEVELOPMENT ---------------------------------------------------------

#    'jetbrains-toolbox'          # IDEA manager
#    'lens-bin'                   # k8s overview
#    'fnm-bin'                    # node version manager

    # MEDIA ---------------------------------------------------------------

#    'screenkey'                 # Screencast your keypresses
    'spotify'                   # music streaming
#    'peek'                      # GIF animation screen recorder

    # PRODUCTIVITY --------------------------------------------------------
    'nb'                         # Note takings tool
    'todoist'                    # to#doist cli client
    'joplin-desktop'             # Note taking with synchronization
#    'sxhkhm-git'                # Fuzzy-find keybinds from sxhkd configuration

    # NETWORK --------------------------------------------------------------

#    'nordvpn-bin'               # nordvpn cli

    # FONTS ---------------------------------------------------------------

   'nerd-fonts-complete-starship'       # nerd fonts
    # 'nerd-fonts-complete'                # complete nerd fonts

    # KEYBOARD -------------------------------------------------------------
   # 'qmk-git'                   # firmware flashing for keyboards
)

# download dropbox public key
#wget https://linux.dropbox.com/fedora/rpm-public-key.asc
#gpg --import rpm-public-key.asc
#rm rpm-public-key.asc

sudo aura -A --noconfirm ${PKGS[@]}

echo
echo "Done!"
echo
