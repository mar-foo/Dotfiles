#!/bin/sh
st -e
{
cd ~/.local/src/dwm/
doas make clean install
cd ~/Github/suckless/dmenu1/
doas make clean install
} && notify-send "Configurations updated!" "Enjoy the new pywal colors"
