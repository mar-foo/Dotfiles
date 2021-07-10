#!/bin/sh
{
cd ~/.local/src/dwm/
doas make clean install
cd ~/Dotfiles/dmenu1/suckless/dmenu1/
doas make clean install
} && notify-send "Configurations updated!" "Enjoy the new pywal colors"
