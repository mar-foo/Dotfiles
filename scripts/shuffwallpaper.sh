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

wall=$(find $HOME/Media/Pictures/wallpapers/dull/ -iname "*.jpg" -or -iname "*.png" | shuf | head -n 1)
$HOME/.local/bin/wal -q -i $wall ; notify-send "Shuffle wallpaper" "$wall"
#st -e cd $HOME/Github/Dotfiles/dwm1 ; doas make clean install ; cd $HOME/Github/Dotfiles/dmenu1 ; doas make clean install
st -g "75x30" -e $HOME/.local/bin/scripts/updatewal.sh
