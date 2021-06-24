#!/bin/bash
current=$(setxkbmap -query | awk '/layout/ {print $2}' | sed 's/\s+$//g')
case $current in
	"dvorak") setxkbmap gb ; xmodmap ~/.Xmodmap ; xcape -e 'Super_L=Escape'
		notify-send "Keyboard Layout: " "GB"
	;;
	"gb") setxkbmap dvorak ; xmodmap ~/.Xmodmap ; xcape -e 'Super_L=Escape'
		notify-send "Keyboard Layout: " "dvorak"
	;;
	*) ;;
esac
