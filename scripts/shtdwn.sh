#!/bin/bash
mode=$(echo -e "Shutdown\nReboot" | dmenu -i -p "Want to shutdown?")
case "$mode" in
	"Shutdown") option=$( echo -e "Yes\nNo" | dmenu -i -p "Are you sure you want to shutdown?" )
		case "$option" in
			"Yes") shutdown -h now;;
			"No") notify-send "Shutdown Aborted";;
			*) notify-send "Shutdown Aborted";;
		esac;;
	"Reboot") option=$( echo -e "Yes\nNo" | dmenu -i -p "Are you sure you want to reboot?")
		case $option in
			"Yes") reboot;;
			"No") notify-send "Reboot Aborted" ;;
			*) notify-send "Reboot Aborted";;
		esac;;
	*) notify-send "Aborted";;
esac
