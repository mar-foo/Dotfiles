#!/bin/sh
setxkbmap dvorak
picom &
hsetroot -cover $HOME/.config/wall.jpg
export _JAVA_AWT_WM_NONREPARENTING=1
pgrep plumber || 9 plumber
exec dwm
