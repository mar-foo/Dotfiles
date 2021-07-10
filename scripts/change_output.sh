#!/bin/bash
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
