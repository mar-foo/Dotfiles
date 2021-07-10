#/bin/bash
# MIT/X Consortium License

# © 2021 Mario Forzanini <mario.forzanini@studenti.unimi.it>

# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
# of the Software, and to permit persons to whom the Software is furnished to do
# so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

BROWSER="$HOME/.local/bin/scripts/surftab.sh"
BROWSERALT="firefox "
	case $1 in
		"Ariel") choice=$(echo -e "Algoritmi e Strutture Dati\nRegistrazioni Algoritmi e Strutture Dati\nAnalisi 2\nCrittografia 1\nRegistrazioni Crittografia\nInformatica Teorica\nMeccanica Analitica\nMeccanica Quantistica\nMetodi Matematici della Fisica\nTermodinamica\nRegistrazioni Termodinamica\nLaboratorio di Ottica\nLaboratorio di Elettronica\nOrario" | dmenu -c -i -l 15 -p "Ariel: " )
			case $choice in
				"Analisi 2") notify-send "Opening Ariel" "Analisi 2" && $BROWSER "https://mcalanchiam2.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Algoritmi e Strutture Dati") notify-send "Opening Ariel" "Algoritmi e Strutture dati per la fisica dei dati" && $BROWSER ""
					;;
				"Registrazioni Algoritmi e Strutture Dati") $HOME/.local/bin/scripts/strutturedati.sh
					;;
				"Crittografia 1") notify-send "Opening Crittografia 1" && $BROWSER "http://www.di.unimi.it/visconti"
					;;
				"Registrazioni Crittografia") notify-send "Opening Vifm" "Lezioni di Crittografia" && st -e vifm ~/Documents/University/Crittografia1 ~
					;;
				"Informatica Teorica") notify-send "Opening Ariel" "Informatica Teorica" && $BROWSER "https://cmereghettiit.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Meccanica Quantistica") notify-send "Opening Ariel" "Meccanica Quantistica" && $BROWSER "https://scaracciolofqm1.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Metodi Matematici della Fisica") notify-send "Opening Ariel" "Metodi Matematici della Fisica" && $BROWSER "https://lmolinarimmf.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Termodinamica") notify-send "Opening Ariel" "Termodinamica" && $BROWSER "https://grossit.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Registrazioni Termodinamica") notify-send "Opening Ariel" "Registrazioni di Termodinamica" && $BROWSERALT "https://unimi2013-my.sharepoint.com/:f:/g/personal/giorgio_rossi2_unimi_it/Es1YIjvFA9JBklttXNRjL4ABnQ9YxZ-FNJSPJhCbWtfYAQ?e=zH9Y9b"
					;;
				"Laboratorio di Ottica") notify-send "Opening Ariel" "Laboratorio di ottica"  && $BROWSER "aguglielmettiloefm.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				"Laboratorio di Elettronica") notify-send "Opening Ariel" "Laboratorio di elettronica" && $BROWSER "https://vliberalie.ariel.ctu.unimi.it/v5/Home/"
					;;
				"Orario") notify-send "Apro il portale degli orari" && $BROWSER "https://easystaff.divsi.unimi.it/PortaleStudenti/index.php?view=easycourse&include=corso&_lang=it&empty_box=0&col_cells=0"
					;;
				#"Analisi 3") notify-send "Opening Ariel " "Analisi 3" && abrowser "eterraneoam3.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
				"Meccanica Analitica") notify-send "Opening Ariel" "Meccanica analitica" && $BROWSER  "acaratima.ariel.ctu.unimi.it/v5/home/Default.aspx"
					;;
				#"Elettromagnetismo") choice=$(echo -e "Ariel\nSito" | dmenu -c -x 768 -y 5.4 -z 384 -i -l 15  -p "Sito: ")
				#case "$choice" in
					#"Ariel") notify-send "Opening Ariel" "Elettromagnetismo" && abrowser"fragusae.ariel.ctu.unimi.it/v5/home/Default.aspx" ;;
					#"Sito") notify-send "Opening Site" "Sito di plasmi" && icecat-bin "http://plasma.fisica.unimi.it/teaching/elettromagnetismo" ;;
					#*);;
				esac;;
		"Archlinux") query=$(echo "" | dmenu -c -g 3 -i -l 15 -p "Arch Wiki: " | sed 's/ /+/g' )
			[[ -z $query ]] || $BROWSER "https://wiki.archlinux.org/index.php?title=Special:Search&search="$query
			;;
		"GentooWiki") query=$(echo "" | dmenu -c -g 3 -l 15 -i -p "Gentoo Wiki: " | sed 's/ /+/g' )
			[[ -z $query ]] || $BROWSER "https://wiki.gentoo.org/index.php?title=Special%3ASearch&search=$query&go=Go#"
			;;
		"Jitsi") notify-send "Opening jitsi" && $BROWSERALT "https://meet.jit.si" ;;
		"LBRY") query=$(echo -e "" | dmenu -c -g 3 -l 15 -i -p "LBRY: " | sed 's/ /-/g')
			[[ -z $query ]] || $BROWSER "https://lbry.tv/search?q="$query
			;;
		"Protonmail") notify-send "Opening Protonmail" && $BROWSER "https://mail.protonmail.com"
			;;
		"Repl") $BROWSER "repl.it";;
		"Searx") query=$(echo -e "" | dmenu -c -g 3 -l 15 -i -p "Searx: " | sed 's/ /\%20/g')
			[[ -z $query ]] || $BROWSER "https://searx.bar/search?q=$query&category=general&language=en_US"
			;;
		"Suckless") program=$(echo -e "dwm\nst\ndmenu" | dmenu -c -g 3 -i -l 15 -p "Suckless: ")
			case "$program" in
				"dwm") $BROWSER "dwm.suckless.org";;
				"st")  $BROWSER "st.suckless.org";;
				"dmenu") $BROWSER "tools.suckless.org/dmenu";;
				*) $BROWSER "suckless.org";;
			esac;;
		"Surf") notify-send "Opening surf" && tabbed surf -e
			;;
		"Tor") notify-send "Opening tor browser" && torbrowser-launcher;;
		"Unimia") notify-send "Opening Unimia" && $BROWSER "unimia.unimi.it";;
		"Url") query=$( cat ~/.surf/bookmarks | dmenu -c -g 3 -l 15 -i -p "Site: ")
			[[ -z $query ]] || $BROWSER "https://"$query
			;;
		"Website") notify-send "Opening personal website" && $BROWSER "marioforzanini.com"
			;;
		*);;

esac
