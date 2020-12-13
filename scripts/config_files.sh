#!/bin/sh

choice=$(echo "bash\ncompton\ndmenu\ndunst\ndwm\nneofetch\nnvim\nstartdwm\nst\nvifm" | dmenu -i -p "Configuration file:")
#if [[ -z nvim ]]; then
#	nvim = "nvim" 
#fi
case "$choice" in
	"bash") st "nvim" "/home/mario/.bashrc";;
	"compton") st nvim "/home/mario/.config/compton.conf";;
	"dmenu") st nvim "/home/mario/suckless/dmenu/config.h";;
	"dunst") st nvim "/home/mario/.config/dunst/dunstrc";;
	"dwm") st nvim "/home/mario/suckless/dwm/config.h";;
	"neofetch") st nvim "/home/mario/.config/neofetch/config.conf";;
	"nvim") st nvim "/home/mario/.config/nvim/init.vim";;
	"startdwm") st nvim "/usr/bin/startdwm";;
	"st") st nvim "/home/mario/suckless/st/config.h";;
	"vifm") st nvim "/home/mario/.config/vifm/vifmrc";;
	*) notify-send "Aborted" "No configuration file chosen";;
esac
