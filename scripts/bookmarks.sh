#!/bin/bash
BROWSER=firefox
	case $1 in
		"Ariel") choice=$(echo -e "Analisi 2\nCrittografia 1\nInformatica Teorica\nMeccanica Quantistica\nMetodi Matematici della Fisica\nTermodinamica\nLaboratorio di Ottica\nOrario" | dmenu -x 768 -y 5.4 -z 384 -i -l 15 -p "Ariel: " )
			case $choice in
				"Analisi 2") notify-send "Opening Ariel" "Analisi 2" && $BROWSER "https://mcalanchiam2.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Crittografia 1") notify-send "Opening Crittografia 1" && $BROWSER "http://www.di.unimi.it/visconti"
					;;
				"Informatica Teorica") notify-send "Opening Ariel" "Informatica Teorica" && $BROWSER "https://cmereghettiit.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Meccanica Quantistica") notify-send "Opening Ariel" "Meccanica Quantistica" && $BROWSER "https://scaracciolofqm1.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Metodi Matematici della Fisica") notify-send "Opening Ariela" "Metodi Matematici della Fisica" && $BROWSER "https://lmolinarimmf.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Termodinamica") notify-send "Opening Ariel" "Termodinamica" && $BROWSER "https://grossit.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Laboratorio di Ottica") notify-send "Opening Ariel" "Laboratorio di ottica"  && abrowser "aguglielmettiloefm.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Orario") notify-send "Apro il portale degli orari" && $BROWSER "https://easystaff.divsi.unimi.it/PortaleStudenti/index.php?view=easycourse&include=corso&_lang=it&empty_box=0&col_cells=0"
				#"Analisi 3") notify-send "Opening Ariel " "Analisi 3" && abrowser "eterraneoam3.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
				#"Meccanica analitica") notify-send "Opening Ariel" "Meccanica analitica" && abrowser  "acaratima.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
				#"Elettromagnetismo") choice=$(echo -e "Ariel\nSito" | dmenu -x 768 -y 5.4 -z 384 -i -l 15  -p "Sito: ")
				#case "$choice" in
					#"Ariel") notify-send "Opening Ariel" "Elettromagnetismo" && abrowser"fragusae.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
					#"Sito") notify-send "Opening Site" "Sito di plasmi" && icecat-bin "http://plasma.fisica.unimi.it/teaching/elettromagnetismo" ;;
					#*);;
				esac;;
		"Archlinux") query=$(echo "" | dmenu -x 768 -y 5.4 -z 384 -i -l 15 -p "Arch Wiki: " | sed 's/ /+/g' )
			[[ -z $query ]] || $BROWSER "https://wiki.archlinux.org/index.php?title=Special:Search&search="$query
			;;
		"GentooWiki") query=$(echo "" | dmenu -x 768 -y 5.4 -z 384 -i -p "Gentoo Wiki: " | sed 's/ /+/g' )
			[[ -z $query ]] || $BROWSER "https://wiki.gentoo.org/index.php?title=Special%3ASearch&search=$query&go=Go#"
			;;
		"Jitsi") notify-send "Opening jitsi" && abrowser "https://meet.jit.si" ;;
		"LBRY") query=$(echo -e "" | dmenu -x 768 -y 5.4 -z 384 -i -p "LBRY: " | sed 's/ /-/g')
			[[ -z $query ]] || $BROWSER "https://lbry.tv/search?q="$query
			;;
		"Repl") $BROWSER "repl.it";;
		"Searx") query=$(echo -e "" | dmenu -x 768 -y 5.4 -z 384 -i -p "Searx: " | sed 's/ /\%20/g')
			[[ -z $query ]] || $BROWSER "https://searx.bar/search?q=$query&category=general&language=en_US"
			;;
		"Suckless") program=$(echo -e "dwm\nst\ndmenu" | dmenu -x 768 -y 5.4 -z 384 -i -l 15 -p "Suckless: ")
			case "$program" in
				"dwm") $BROWSER "dwm.suckless.org";;
				"st")  $BROWSER "st.suckless.org";;
				"dmenu") $BROWSER "tools.suckless.org/dmenu";;
				*) $BROWSER "suckless.org";;
			esac;;
		"Tor") notify-send "Opening tor browser" && torbrowser-launcher;;
		"Unimia") notify-send "Opening Unimia" && $BROWSER "unimia.unimi.it";;
		"Url") query=$(echo -e "" | dmenu -x 768 -y 5.4 -z 384 -i -p "Site: ")
			$BROWSER "https://"$query
			;;
		*);;

esac
