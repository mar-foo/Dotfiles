#!/bin/sh
mode=$(printf "Shutdown\nReboot" | dmenu  -i -p "Want to shutdown?")
case "$mode" in
	"Shutdown") option=$(printf "Yes\nNo" | dmenu -i -p "Are you sure you want to shutdown?")
	if test $option = Yes; then
	notify-send "Shutting down"
	doas halt
	else
	notify-send "Shutdown aborted"
	fi
	;;
	"Reboot") option=$(printf "Yes\nNo" | dmenu -i -p "Are you sure you want to reboot?")
	if test $option = Yes; then
	notify-send "Rebooting the system"
	doas reboot
	else
	notify-send "Reboot aborted"
	fi
	;;
	*) notify-send "Aborted"
	;;
esac
