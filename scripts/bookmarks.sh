#!/bin/bash
choice=$(echo -e "Ariel\nArchlinux\nJitsi\nLBRY\nRepl\nSuckless\nTor\nUnimia" | dmenu -i -p "Browse:" )
BROWSER=$"icecat-bin"
	case "$choice" in
		"Ariel") choice=$(echo -e "Analisi 3\nElettromagnetismo\nLaboratorio di Ottica\nLaboratorio di trattamento\nMeccanica analitica" | dmenu -i  -p "Sito: " )
			case $choice in
				"Analisi 3") notify-send "Opening Ariel " "Analisi 3" && abrowser "eterraneoam3.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
				"Meccanica analitica") notify-send "Opening Ariel" "Meccanica analitica" && abrowser  "acaratima.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
				"Laboratorio di Ottica") notify-send "Opening Ariel" "Laboratorio di ottica"  && abrowser "aguglielmettiloefm.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
				"Elettromagnetismo") choice=$(echo -e "Ariel\nSito" | dmenu -i  -p "Sito: ")
				case "$choice" in
					"Ariel") notify-send "Opening Ariel" "Elettromagnetismo" && abrowser"fragusae.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
					"Sito") notify-send "Opening Site" "Sito di plasmi" && icecat-bin "http://plasma.fisica.unimi.it/teaching/elettromagnetismo" ;;
					*);;
				esac;;
			"Laboratorio di trattamento") choice=$(echo -e "Ariel\nSito" | dmenu -i  -p "Sito: ")
				case "$choice" in
					"Ariel") notify-send "Opening Ariel" "Laboratorio di trattamento numerico dei dati sperimentali" && abrowser "ltnds.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
					"Sito")  notify-send "Opening site" "Laboratorio di calcolo" && icecat-bin "labmaster.mi.infn.it";;
					*);;
				esac;;
				*);;
			esac;;
		"Archlinux") query=$(echo "" | dmenu -i -p "query" | sed 's/ /+/g' )
			case "$query" in
				"")notify-send "Aborted";;
				*)$BROWSER "https://wiki.archlinux.org/index.php?title=Special:Search&search="$query
			;;
			esac;;
		"Jitsi") notify-send "Opening jitsi" && abrowser "https://meet.jit.si" ;;
		"LBRY") query=$(echo -e "" | dmenu -i -p "query" | sed 's/ /-/g')
			case "$query" in
				"") notify-send "Aborted";;
				*) $BROWSER "https://lbry.tv/$/search?q="$query
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
		"Tor") notify-send "Opening tor browser" && torbrowser-launcher;;
		"Unimia") notify-send "Opening Unimia" && icecat-bin "unimia.unimi.it";;
		"") ;;
		*) notify-send "Searching:" "$choice" && choice=$(echo "$choice" | sed 's/ /+/g') && $BROWSER "https://duckduckgo.com/?q="$choice;;

esac
