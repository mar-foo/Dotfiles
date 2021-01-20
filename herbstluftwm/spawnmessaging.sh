#!/bin/bash

tag=
hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}

currTag=$(hc attr tags.focus | awk '/name/ {print $5}' | sed 's/"//g;s/\s+$//g')
clients=$(hc attr tags.focus | awk '/client/ {print $5}' | sed 's/"//g;s/\s+$//g')
messtag=$(hc tag_status | awk '{print $6}' | sed 's///g')

if [[ $currTag == $tag ]]; then
	if [[ $clients -eq 0 ]]; then
		hc spawn session-desktop-linux-x86_64-1.4.4.AppImage
	fi
else
	case "$messtag" in
		".") hc chain , use $tag , spawn session-desktop-linux-x86_64-1.4.4.AppImage;;
		":") hc spawn ~/.config/herbstluftwm/messaging.sh;;
	esac
fi

