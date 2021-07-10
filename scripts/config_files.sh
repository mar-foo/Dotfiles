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


choice=$(echo "bash\ncompton\ndmenu\ndunst\ndwm\nherbstluft\nmocp\nneofetch\nnvim\nqutebrowser\nstartdwm\nst\nvifm" | dmenu -i -p "Configuration file:")
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
