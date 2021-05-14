#!/bin/sh
wal -i $1 # Modify pywal color palettes and the background
sed -i '/SchemeUrg/d;s/sel_border\[\].*$/sel_border\[\] = "#900000";/' $HOME/.cache/wal/colors-wal-dwm.h # Set border color to always be red
sed '/^st/d;/{/d;/}/d' ~/.local/bin/scripts/updatewal.sh | /bin/sh # Update suckless binaries from the terminal you are in
