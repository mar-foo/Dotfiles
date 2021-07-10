#!/bin/bash
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

