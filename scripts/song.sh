#!/bin/sh
notify-send "Playing $1 , \"$2\" " ; echo "$1, $2" > /home/mario/.local/bin/song.txt ; echo "playing" > ~/.local/bin/playing.txt
