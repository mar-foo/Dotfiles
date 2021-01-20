#!/bin/sh

choice=$(echo "bash\ncompton\ndmenu\ndunst\ndwm\nherbstluft\nmocp\nneofetch\nnvim\nqutebrowser\nstartdwm\nst\nvifm" | dmenu -i -p "Configuration file:")
#if [[ -z nvim ]]; then
#	nvim = "nvim"
#fi
case "$choice" in
	"bash") st "nvim" "/home/mario/.bashrc";;
	"compton") st nvim "/home/mario/.config/compton.conf";;
	"dmenu") st nvim "/home/mario/suckless/dmenu/config.h";;
	"dunst") st nvim "/home/mario/.config/dunst/dunstrc";;
	"dwm") st nvim "/home/mario/suckless/dwm/config.h";;
	"herbstluft") st nvim "/home/mario/.config/herbstluftwm/autostart";;
	"mocp") st nvim "/home/mario/.moc/.config";;
	"neofetch") st nvim "/home/mario/.config/neofetch/config.conf";;
	"nvim") st nvim "/home/mario/.config/nvim/init.vim";;
	"qutebrowser") st nvim "/home/mario/.config/qutebrowser/config.py";;
	"startdwm") st nvim "/usr/bin/startdwm";;
	"st") st nvim "/home/mario/suckless/st/config.h";;
	"vifm") st nvim "/home/mario/.config/vifm/vifmrc";;
	*) notify-send "Aborted" "No configuration file chosen";;
esac
