#!/bin/sh
aula=$(echo -e "aula.b\naula.i" | dmenu -i -c -l -1 -p "Aula:")
open_zoom() {
echo $aula | xclip -i
/usr/bin/zoom
}

test -z $aula || open_zoom
