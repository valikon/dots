#!/usr/bin/env bash
echo
echo "INSTALLING XORG"
echo

PKGS=(
    'xorg-server'           # XOrg server
    'xorg-apps'             # XOrg apps group
    'xorg-xinit'            # XOrg init
    'xdotool'               # cli X11 automation tool
    'xclip'                 # cli interface to the x11 clipboard
	'libx11'                # X11 client-side lib
	'libxft'                # font drawing lib for X
	'libxinerama'           # Xinerama extension lib
	'libxrandr'             # X11 RandR extension lib
	'libxss'                # X11 Screen Save extension lib
	'pkgconf'               # Package compile and linker metadata toolkit
#        'xf86-video-intel'      # 2D/3D video driver
#        'mesa'                  # Open source version of OpenGL
        'xf86-input-libinput'   # Trackpad driver for Dell XPS
)

sudo pacman -S "${PKGS[@]}" --noconfirm --needed

echo
echo "Done!"
echo
