#!/bin/bash
choice=$(echo -e "Ariel\nArchlinux\nDuckDuckgo\nJitsi\nLBRY\nRepl\nSuckless\nWhatsapp\nZoom" | dmenu -i -p "Firefox:")
BROWSER="vimb"

case "$choice" in
	"Ariel") firefox "ariel.unimi.it";;
	"Archlinux") query=$(echo "" | dmenu -i -p "query" | sed 's/ /+/g' )
		case "$query" in 
			"");;
			*)$BROWSER "https://wiki.archlinux.org/index.php?title=Special:Search&search="$query
		;;
		esac;;
	"DuckDuckgo") query=$(echo "" | dmenu -i -p "query" | sed 's/ /+/g')
		case "$query" in
			"") ;;
			*)$BROWSER "https://duckduckgo.com/?q="$query
		;;
		esac;;
	"Jitsi") firefox "https://meet.jit.si";;
	"LBRY") query=$(echo -e "" | dmenu -i -p "query")
		case "$query" in
			"") ;;
			*) firefox "https://lbry.tv/$/search?q="$query
		;;
		esac;;
	"Repl") $BROWSER "repl.it";;
	"Suckless") program=$(echo -e "dwm\nst\ndmenu" | dmenu -i -p "Which page?")
		case "$program" in
			"dwm") $BROWSER "dwm.suckless.org";;
			"st")  $BROWSER "st.suckless.org";;
			"dmenu") $BROWSER "tools.suckless.org/dmenu";;
			*) $BROWSER "suckless.org";;
		esac;;
	"Whatsapp") firefox "web.whatsapp.com";;
	"Zoom") firefox "zoom.us";;
	*) ;;
esac

