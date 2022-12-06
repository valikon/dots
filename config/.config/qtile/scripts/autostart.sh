#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}



#starting utility applications at boot time
lxsession &
run nm-applet &
run pamac-tray &
numlockx on &
blueman-applet &
flameshot &
picom --config .config/picom/picom-blur.conf --experimental-backends &
dunst &
variety &
sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
wal -R &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
#picom --config $HOME/.config/picom/picom.conf &

run volumeicon &
run dropbox &
emacs --daemon &
docker start whoogle-search &
xmodmap ~/.Xmodmap
#thunderbird &
#slack &
#run discord &
#run caffeine -a &
#run vivaldi-stable &
#run qutebrowser &
#run nemo &
#run insync start &
#run spotify &
#run telegram-desktop &
#~/.local/share/kite/kited &

# setup screen
#screen1
