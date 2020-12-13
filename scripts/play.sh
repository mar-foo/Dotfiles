#!/bin/bash
killall -q mocp ;
artist=$(ls /home/mario/Music | grep "[A-Z]" | dmenu -i -p "Artist:")
if [[ "$artist" != "" ]]; then
	album=$(ls "/home/mario/Music/$artist" | dmenu -i -p "Album:")
	if [[ "$album" != "" ]]; then
		mocp --config /home/mario/.moc/.config -m "/home/mario/Music/$artist/$album" 
	fi
fi

