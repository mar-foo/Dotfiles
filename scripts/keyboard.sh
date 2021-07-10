#!/bin/bash
current=$(setxkbmap -query | awk '/layout/ {print $2}' | sed 's/\s+$//g')
case $current in
	"it") setxkbmap gb && notify-send "Changed keyboard layout" "gb" ; xmodmap ~/.Xmodmap ; xcape -e 'Super_L=Escape'
	;;
	"gb") setxkbmap it && notify-send "Changed keyboard layout" "it" ; xmodmap ~/.Xmodmap ; xcape -e 'Super_L=Escape'
	;;
	*) ;;
esac
