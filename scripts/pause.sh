#!/bin/bash
state=$(cat ~/.local/bin/playing.txt)
if [[ "$state" = "playing" ]]; then
	mocp -P ; notify-send "Paused" ; echo "paused" > ~/.local/bin/playing.txt
elif [[ "$state" = "paused" ]]; then
	mocp -U ; notify-send "Resumed"; echo "playing" > ~/.local/bin/playing.txt
fi
