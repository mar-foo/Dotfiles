#!/bin/sh

if test -z $(tmux ls | grep music &2>/dev/null); then
  st -e tmux new-session -s "music" cmus
else
  st -e tmux a -t "music"
fi
