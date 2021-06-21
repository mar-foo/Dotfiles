#!/bin/sh
# Author: Mario Forzanini https://marioforzanini.com
# Date: 14/05/2021
# Description: Wrapper around pywal used to set wallpaper
# Dependencies: pywal https://www.github.com/dylanaraps/pywal

new_wall() {
				wal -i $1 # Modify pywal color palettes and the background
				sed -i '/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
				notify-send -i $PWD/$1 "Wallpaper updated."
				$HOME/.local/bin/scripts/updatewal.sh # Update suckless binaries
				#sed '/^st/d;/{/d;/}/d' $HOME/.local/bin/scripts/updatewal.sh | /bin/sh # Update suckless binaries from the terminal you are in
				exit
}

reload_wall() {
				wal -R # Reload last wallpaper
				sed -i '/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
				exit
}

interactive_wall() {
				new_wall=$(find $HOME/Media/Pictures/wallpapers/ -type f -iname "*.jpg" -or -iname "*.png" | sed 's/^.*wallpapers\///' | dmenu -i -p "New wallpaper: ")
				test -z $new_wall ||
								{ wal -i $HOME/Media/Pictures/wallpapers/$new_wall
												sed -i '/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
												$HOME/.local/bin/scripts/updatewal.sh # Update suckless binaries spawning a new terminal
								}
				#sed '/^st/d;/{/d;/}/d' $HOME/.local/bin/scripts/updatewal.sh | /bin/sh # Update suckless binaries from the terminal you are in
				exit
}

gruvbox() {
				wal --theme base16-gruvbox-hard
				sed -i 's/sel_bg\[\].*$/sel_bg[] = "#fb4934";/;/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
        hsetroot -cover $HOME/Media/Pictures/wallpapers/dwm-gruvbox.png
				$HOME/.local/bin/scripts/updatewal.sh # Update suckless binaries spawning a new terminal
				exit
}

print_usage() {
				printf "Usage:\n\tsetbg [OPTIONS]\nOPTIONS:\n\t-d: Get a dmenu prompt to choose wallpaper\n\t-h:\t Print this help message\n\t-i: Image\t Set image as background\n\t-R:\t Reload previous backround\n"
}

while getopts ":ghi:dR" o; do case "${o}" in
				d) interactive_wall
				;;
g) gruvbox
				;;
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
