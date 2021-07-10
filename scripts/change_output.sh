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

# Author: Mario Forzanini https://marioforzanini.com
# Date: 18/05/2021
# Description: Change audio output
# Dependencies: pacmd, pulseaudio

sinkIndexes=( $(pacmd list-sink-inputs | grep 'index' | cut -d: -f2) )
sinkNames=( $(pacmd list-sink-inputs | grep 'application\.name' | sed 's/ /_/g' | cut -d\" -f2) )
nSinks=${#sinkIndexes[@]}
outputIndexes=( $(pacmd list-sinks | grep 'index' | cut -d: -f2) )
outputNames=( $(pacmd list-sinks | grep "^\s\+name:" | cut -d: -f2) )
nOutputs=${#sinkIndexes[@]}
outputs=
sinks=

for i in nSinks; do
	${sinks[$i]}=$(printf "$(echo ${sinkNames[$i]} ${sinkIndexes[$i]})\n")
done
for i in nOutputs; do
	${outputs[$i]}=$(printf "$(echo "${outputNames[$i]} ${outputIndexes[$i]}")\n")
done

echo ${sinks}
echo ${outputs}

chosenSink=$(printf ${sinks} | dmenu -i -c -p "Sink to move: " | \
    cut -d\( -f2 | sed 's/)//')
test -z $chosenSink && exit 1
chosenOutput=$(printf ${outputs} | dmenu -i -c -p "Move to output: " | \
    cut -d\( -f2 | sed 's/)//')
test -z $chosenOutput && exit 1

pacmd move-sink-input ${chosenSink# *} ${chosenOutput# *}
exit
