#!/bin/sh
EDITOR="st -e vim "
SCRIPTDIR="$HOME/.local/bin/scripts/"
script=$(ls $SCRIPTDIR | dmenu -c -l 15 -g 3 -i -p "Edit script:")
[[ -z $script ]] || $EDITOR $SCRIPTDIR$script
