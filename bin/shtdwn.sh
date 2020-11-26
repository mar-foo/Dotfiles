#!/bin/bash
mode=$(echo -e "Shutdown\nReboot" | dmenu -l 2 -i -p "Want to shutdown?")
case "$mode" in
	"Shutdown") option=$(echo -e "Yes\nNo" | dmenu -l 2 -i -p "Are you sure you want to shutdown?")
		case "$option" in
			"Yes") shutdown -h now;;
			"No") echo -e "Accept" | dmenu -p "Shutdown aborted";;
			*) echo -e "Accept" | dmenu -p "Shutdown aborted ";;
		esac;;
	"Reboot") option=$(echo -e "Yes\nNo" | dmenu -l 2 -i -p "Are you sure you want to reboot?")
		case $option in
			"Yes") reboot;;
			"No") echo -e "Accept" | dmenu -p "Reboot aborted";;
			*) echo -e "Accept" | dmenu -p "Reboot aborted";;
		esac;;
esac
