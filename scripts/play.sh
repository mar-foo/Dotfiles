#!/bin/bash
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

killall -q mocp ;
artist=$(ls /home/mario/Media/Music | grep "[A-Z]" | dmenu -c -l 15 -g 3 -i -p "Artist:")
if [[ "$artist" != "" ]]; then
	album=$(ls "/home/mario/Media/Music/$artist" | dmenu -c -l 15 -g 3 -i -p "Album:")
	if [[ "$album" != "" ]]; then
		st -e mocp --config /home/mario/.moc/.config -m "/home/mario/Media/Music/$artist/$album"
	else
		#notify-send "Aborted" ; exit 1
		~/.local/bin/scripts/play.sh
	fi
else
	notify-send "Aborted" ; exit 1
fi

