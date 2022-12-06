#!/usr/bin/env bash

echo
echo "INSTALLING ESSENTIAL AUR PACKAGES"
echo

#cd "${HOME}"
#
#echo "CLONING: PARU"
#git clone "https://aur.archlinux.org/paru.git"


PKGS=(

    # RICE ----------------------------------------------------------------

    'sddm-sugar-dark'           # sddm theme

    # SYSTEM UTILITIES ----------------------------------------------------

    'gtkhash'                   # Checksum verifier

    # TERMINAL UTILITIES --------------------------------------------------

    'bitwarden-cli'              # Password manager CLI client
    'aura-bin'                   # AUR package manager
    'aws-cli-v2-bin'             # cli v2 for AWS
    'skroll'                     # text scroller
    'lsdesktopf'                 # list available .desktop files and search content
    'find-the-command-git'       # command not found hook

    # GENERAL UTILITIES ---------------------------------------------------

    'bitwarden'                  # Password manager
    'samba'                      # Samba File Sharing
    'autofs'                     # Auto-mounter
    'i3lock-color'               # lockscreen, required by betterlockscreen
    'betterlockscreen'           # lockscreen
    'todoist'                    # todoist cli client

    # DEVELOPMENT ---------------------------------------------------------

    'coursier-native'            # Pure Scala artifact fetching
    'jetbrains-toolbox'          # IDEA manager
    'lens-bin'                   # k8s overview
    'fnm-bin'                    # node version manager

    # MEDIA ---------------------------------------------------------------

    'screenkey'                 # Screencast your keypresses
    'spotify'                   # music streaming
    'peek'                      # GIF animation screen recorder

    # PRODUCTIVITY --------------------------------------------------------

    'sxhkhm-git'                # Fuzzy-find keybinds from sxhkd configuration
    'dropbox'                   # cloud storage
    'slack-desktop'             # office chat
    'teams-for-linux'           # video conference

    # NETWORK --------------------------------------------------------------

    'nordvpn-bin'               # nordvpn cli

    # FONTS ---------------------------------------------------------------

    'nerd-fonts-complete-starship'       # nerd fonts
    'nerd-fonts-complete'                # complete nerd fonts

    # KEYBOARD -------------------------------------------------------------
    'qmk-git'                   # firmware flashing for keyboards
)


#cd ${HOME}/paru
#makepkg -si

# download dropbox public key
wget https://linux.dropbox.com/fedora/rpm-public-key.asc
gpg --import rpm-public-key.asc
rm rpm-public-key.asc

for PKG in "${PKGS[@]}"; do
    paru -S --noconfirm $PKG
done

echo
echo "Done!"
echo
