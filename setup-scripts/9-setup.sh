#!/usr/bin/env bash

echo
echo "FINAL SETUP AND CONFIGURATION"

# ------------------------------------------------------------------------

sudo ufw enable
sudo systemctl enable fstrim.timer
setxkbmap us -variant euro

# change default shell
chsh -s $(which fish)

# sdkman for jvm tools
curl -s "https://get.sdkman.io" | bash

# Fish shell packages and plugins
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

omf install fzf pj aws z
fisher install reitzig/sdkman-for-fish@v1.4.0
fisher install danhper/fish-ssh-agent
fisher install jorgebucaran/autopair.fish
fisher install jorgebucaran/getopts.fish

# python libs to install
pip install --user --upgrade neovim
pip install --user --upgrade neovim-remote

# npm
mkdir -p $HOME/.npm-global
npm config set prefix '~/.npm-global'
npm i -g aws-cdk
npm i -g eslint
npm i -g pyright
npm i -g ts-node
npm i -g typescript-language-server
npm i -g typescript
npm i -g yaml-language-server

#echo
#echo "Generating .xinitrc file"

# Generate the .xinitrc file so we can launch XFCE from the
# terminal using the "startx" command
#cat <<EOF > ${HOME}/.xinitrc
##!/bin/bash
#if [ -d /etc/X11/xinit/xinitrc.d ] ; then
#    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
#        [ -x "\$f" ] && . "\$f"
#    done
#    unset f
#fi
#source /etc/xdg/xfce4/xinitrc
#exit 0
#EOF

# ------------------------------------------------------------------------

#echo
#echo "Updating /bin/startx to use the correct path"
#
## By default, startx incorrectly looks for the .serverauth file in our HOME folder.
#sudo sed -i 's|xserverauthfile=\$HOME/.serverauth.\$\$|xserverauthfile=\$XAUTHORITY|g' /bin/startx

# ------------------------------------------------------------------------

#echo
#echo "Configuring LTS Kernel as a secondary boot option"

#sudo cp /boot/loader/entries/arch.conf /boot/loader/entries/arch-lts.conf
#sudo sed -i 's|Arch Linux|Arch Linux LTS Kernel|g' /boot/loader/entries/arch-lts.conf
#sudo sed -i 's|vmlinuz-linux|vmlinuz-linux-lts|g' /boot/loader/entries/arch-lts.conf
#sudo sed -i 's|initramfs-linux.img|initramfs-linux-lts.img|g' /boot/loader/entries/arch-lts.conf

# ------------------------------------------------------------------------

#echo
#echo "Configuring MAKEPKG to use all 4 cores"
#
#sudo sed -i -e 's|[#]*MAKEFLAGS=.*|MAKEFLAGS="-j$(nproc)"|g' makepkg.conf
#sudo sed -i -e 's|[#]*COMPRESSXZ=.*|COMPRESSXZ=(xz -c -T 4 -z -)|g' makepkg.conf

# ------------------------------------------------------------------------

#echo
#echo "Configuring vconsole.conf to set a larger font for login shell"
#
#sudo cat <<EOF > /etc/vconsole.conf
#KEYMAP=pl
#FONT=ter-v32b
#EOF

# ------------------------------------------------------------------------

#echo
#echo "Disabling buggy cursor inheritance"
#
## When you boot with multiple monitors the cursor can look huge. This fixes it.
#sudo cat <<EOF > /usr/share/icons/default/index.theme
#[Icon Theme]
##Inherits=Theme
#EOF

# ------------------------------------------------------------------------

#echo
#echo "Enabling bluetooth daemon and setting it to auto-start"
#
#sudo sed -i 's|#AutoEnable=false|AutoEnable=true|g' /etc/bluetooth/main.conf
#sudo systemctl enable bluetooth.service
#sudo systemctl start bluetooth.service

# ------------------------------------------------------------------------

echo
echo "Enabling the cups service daemon so we can print"

systemctl enable org.cups.cupsd.service
systemctl start org.cups.cupsd.service

# ------------------------------------------------------------------------

#echo
#echo "Enabling Network Time Protocol so clock will be set via the network"
#
#sudo ntpd -qg
#sudo systemctl enable ntpd.service
#sudo systemctl start ntpd.service

# ------------------------------------------------------------------------

#echo
#echo "NETWORK SETUP"
#echo
#echo "Find your IP Link name:"
#echo
#
#ip link
#
#echo
#read -p "ENTER YOUR IP LINK: " LINK
#
#echo
#echo "Disabling DHCP and enabling Network Manager daemon"
#echo
#
#sudo systemctl disable dhcpcd.service
#sudo systemctl stop dhcpcd.service
#sudo ip link set dev ${LINK} down
#sudo systemctl enable NetworkManager.service
#sudo systemctl start NetworkManager.service
#sudo ip link set dev ${LINK} up
#
#echo "Done!"
#echo
#echo "Reboot now..."
#echo
