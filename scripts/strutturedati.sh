#!/bin/sh
count=$(awk '/videolectures/ {print $2}' ~/Documents/University/Strutture_Dati/strutturedati.html | wc -l)
lesson=$(seq $count | dmenu -c -l $count -g 3)
link=$(awk '/videolectures/ {print $2}' ~/Documents/University/Strutture_Dati/strutturedati.html | sed 's/"$//g;s/src="//g' | tail -n $lesson | head -n 1)
test -z $link || notify-send "Strutture Dati" "Lezione $lesson" ; mpv $link
