#!/bin/sh
# Author: Mario Forzanini https://marioforzanini.com
# Date: 14/05/2021
# Description: Wrapper around pywal used to set wallpaper
# Dependencies: pywal https://www.github.com/dylanaraps/pywal

new_wall() {
wal -i $1 # Modify pywal color palettes and the background
sed -i '/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
sed '/^st/d;/{/d;/}/d' ~/.local/bin/scripts/updatewal.sh | /bin/sh # Update suckless binaries from the terminal you are in
exit
}

reload_wall() {
wal -R # Reload last wallpaper
sed -i '/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
exit
}

print_usage() {
printf "Usage:\n\tsetbg [OPTIONS]\nOPTIONS:\n\t-h:\t Print this help message\n\t-i: Image\t Set image as background\n\t-R:\t Reload previous backround\n"
}

while getopts ":hi:R" o; do case "${o}" in
			h) print_usage 
			exit
			;;
			i) new_wall $OPTARG
			exit
			;;
			R) reload_wall
			;;
			*) print_usage
			exit 1
			;;
	esac
done
