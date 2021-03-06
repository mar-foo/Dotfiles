#!/bin/bash
killall -q mocp ;
artist=$(ls /home/mario/Media/Music | grep "[A-Z]" | dmenu -x 768 -y 5.4 -z 384 -l -1 -i -p "Artist:")
if [[ "$artist" != "" ]]; then
	album=$(ls "/home/mario/Media/Music/$artist" | dmenu -x 768 -y 5.4 -z 384 -l -1 -i -p "Album:")
	if [[ "$album" != "" ]]; then
		st -e mocp --config /home/mario/.moc/.config -m "/home/mario/Media/Music/$artist/$album"
	else
		#notify-send "Aborted" ; exit 1
		~/.local/bin/scripts/play.sh
	fi
else
	notify-send "Aborted" ; exit 1
fi

