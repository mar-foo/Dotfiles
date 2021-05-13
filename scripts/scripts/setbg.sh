#!/bin/bash
wall=$(find $HOME/Media/Pictures/wallpapers/ -type f | shuf -n 1)
wal -i $wall 
sed -i '/SchemeUrg/d' $HOME/.cache/wal/colors-wal-dwm.h
echo "Use this wallpaper?"
while $(read approved); do
if [[ "$approved" == "y" ]]; then
$HOME/.local/bin/scripts/updatewal.sh
exit
else
wall=$(find $HOME/Media/Pictures/wallpapers/ -type f | shuf -n 1)
wal -i $wall >/dev/null
sed -i '/SchemeUrg/d' $HOME/.cache/wal/colors-wal-dwm.h
echo "Use this wallpaper?"
fi
done
