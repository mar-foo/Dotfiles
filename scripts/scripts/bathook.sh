#!/bin/sh
while (true) do
	bat=$(cat /sys/class/power_supply/BAT0/capacity)
	if [[ $bat -eq 10 ]]; then
		notify-send -t -1 "Plug me in"
	elif [[ $bat -eq 5 ]];
		notify-send -t -1 "PLUG ME IN"
	fi
	sleep 120s
done
