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

choice=$(echo "" | dmenu -c -l 2 -i -p "Quante ore vuoi studiare?")
case "$choice" in
	"1") notify-send "1 ora" "Hai scelto di studiare per un'ora";;
	"") notify-send "Aborted" ; exit 1;;
	*) notify-send "$choice ore" "Hai scelto di studiare per $choice ore";;
esac
~/.local/bin/scripts/play.sh &
sleep 2
notify-send "Studio" "Inizia la prima ora di studio"
echo $(date '+%d/%m, %H:%M') >> ~/.local/bin/study.txt
for ((i=1; i<$choice;i++))
do
	sleep 3600
	mocp -P && notify-send "Pausa" "Stai studiando da un'ora"
	sleep 120
	mocp -U && notify-send "Riprendi" "Studia ancora un'ora"
done
sleep 3600
mocp -s ; notify-send "Fine" "Hai studiato per $choice ore"
echo $(date '+%d/%m, %H:%M') >> ~/.local/bin/study.txt
again=$(echo -e "Si\nNo" | dmenu -c -i -p "Vuoi studiare ancora?")
case "$again" in
	"Si") /home/mario/.local/bin/scripts/work.sh;;
	*) notify-send "Fine sessione di studio";;
esac
