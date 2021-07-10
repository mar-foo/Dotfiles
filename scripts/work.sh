#!/bin/bash
choice=$(echo "" | dmenu -c -l 2 -i -p "Quante ore vuoi studiare?")
case "$choice" in
	"1") notify-send "1 ora" "Hai scelto di studiare per un'ora";;
	"") notify-send "Aborted" ; exit 1;;
	*) notify-send "$choice ore" "Hai scelto di studiare per $choice ore";;
esac
~/.local/bin/scripts/play.sh &
sleep 2
notify-send "Studio" "Inizia la prima ora di studio"
echo $(date '+%d/%m, %H:%M') >> ~/.local/bin/study.txt
for ((i=1; i<$choice;i++))
do
	sleep 3600
	mocp -P && notify-send "Pausa" "Stai studiando da un'ora"
	sleep 120
	mocp -U && notify-send "Riprendi" "Studia ancora un'ora"
done
sleep 3600
mocp -s ; notify-send "Fine" "Hai studiato per $choice ore"
echo $(date '+%d/%m, %H:%M') >> ~/.local/bin/study.txt
again=$(echo -e "Si\nNo" | dmenu -c -i -p "Vuoi studiare ancora?")
case "$again" in
	"Si") /home/mario/.local/bin/scripts/work.sh;;
	*) notify-send "Fine sessione di studio";;
esac
