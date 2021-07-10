#!/bin/sh
# MIT/X Consortium License

# © 2021 Mario Forzanini <mario.forzanini@studenti.unimi.it>

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# Author: Mario Forzanini https://marioforzanini.com
# Date: 14/05/2021
# Description: Wrapper around pywal used to set wallpaper
# Dependencies: pywal https://www.github.com/dylanaraps/pywal

new_wall() {
wal -i $1 # Modify pywal color palettes and the background
sed -i '/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
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

print_usage() {
printf "Usage:\n\tsetbg [OPTIONS]\nOPTIONS:\n\t-d: Get a dmenu prompt to choose wallpaper\n\t-h:\t Print this help message\n\t-i: Image\t Set image as background\n\t-R:\t Reload previous backround\n"
}

while getopts ":hi:dR" o; do case "${o}" in
			d) interactive_wall
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
