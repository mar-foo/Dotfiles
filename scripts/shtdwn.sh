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

mode=$(echo -e "Shutdown\nReboot" | dmenu -c -l 15 -g 3 -i -p "Want to shutdown?")
case "$mode" in
	"Shutdown") option=$( echo -e "Yes\nNo" | dmenu -c -l 15 -g 3 -i -p "Are you sure you want to shutdown?" )
		case "$option" in
			"Yes") shutdown -h now;;
			"No") notify-send "Shutdown Aborted";;
			*) notify-send "Shutdown Aborted";;
		esac;;
	"Reboot") option=$( echo -e "Yes\nNo" | dmenu -c -l 15 -g 3 -i -p "Are you sure you want to reboot?")
		case $option in
			"Yes") reboot;;
			"No") notify-send "Reboot Aborted" ;;
			*) notify-send "Reboot Aborted";;
		esac;;
	*) notify-send "Aborted";;
esac
