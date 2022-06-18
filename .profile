#!/bin/sh
# Compilation
MAKEFLAGS="-j$(nproc)"
CFLAGS="-O3 -pipe -march=native"
CXXFLAGS="${CFLAGS}"

# Global variables
EDITOR="vis"
VISUAL="${EDITOR}"
LANG=en_US.UTF-8
MBSYNCRC="$HOME/.config/mutt/mbsyncrc"

PATH="$HOME/go/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

for d in $(find $HOME/bin -maxdepth 2 -type d); do
	PATH="$d:$PATH"
done

export CFLAGS CXXFLAGS EDITOR LANG MAKEFLAGS MBSYNCRC PATH VISUAL
[ $(tty) = "/dev/tty1" ] && sx
