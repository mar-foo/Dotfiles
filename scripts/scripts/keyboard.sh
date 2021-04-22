#!/bin/bash
current=$(setxkbmap -query | awk '/layout/ {print $2}' | sed 's/\s+$//g')
case $current in
	"it") setxkbmap it ; xmodmap ~/.Xmodmap ; xcape -e 'Super_L=Escape'
	;;
	"gb") setxkbmap gb ; xmodmap ~/.Xmodmap ; xcape -e 'Super_L=Escape'
	;;
	*) ;;
esac
