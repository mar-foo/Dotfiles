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

#hour=$(calcurse -n | grep "\[" | sed 's/.*\[//g;s/:.*$//g')
#currhour=$(date '+%H')
#newhour=$(echo $hour | awk '{print $1 + $currhour}')
#minute=$(calcurse -n | grep "\[" | sed 's/.*\://g;s/\].*$//g')
#newminute=$(echo $hour | awk '{print $newminute + $currminute}')
#currminute=$(date '+%M')
#if [[ $newminute -ge 60 ]]; then
	#(($newhour+=1))
	#(($newminute-=60))
#fi
#echo "$newhour:$newminute"

notify-send -t 0 "$(calcurse --next | grep "\[" | sed 's/\].*$//g;s/^.*\[//g' | awk -F':' '{print $1 " ore " $2 " minuti"}')" "$(calcurse --next | grep "\[" | sed 's/^.*[0-9]\]\s//g')"
