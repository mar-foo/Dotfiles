#!/bin/bash
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
