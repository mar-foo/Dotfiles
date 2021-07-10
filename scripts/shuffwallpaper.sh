#!/bin/sh
wall=$(find $HOME/Media/Pictures/wallpapers/dull/ -iname "*.jpg" -or -iname "*.png" | shuf | head -n 1)
$HOME/.local/bin/wal -q -i $wall ; notify-send "Shuffle wallpaper" "$wall"
#st -e cd $HOME/Github/Dotfiles/dwm1 ; doas make clean install ; cd $HOME/Github/Dotfiles/dmenu1 ; doas make clean install
st -g "75x30" -e $HOME/.local/bin/scripts/updatewal.sh
