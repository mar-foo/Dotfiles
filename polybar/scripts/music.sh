#!/bin/bash
if [[ $(cat $HOME/.local/bin/playing.txt) == "playing" ]]; then
	echo " $(cat $HOME/.local/bin/song.txt)"
elif [[ $(cat $HOME/.local/bin/playing.txt) == "paused" ]]; then
	echo " $(cat $HOME/.local/bin/song.txt)  "
else
	echo ""
fi
