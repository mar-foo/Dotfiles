#!/bin/sh

notify-send -t 0 "$(calcurse --next | grep "\[" | sed 's/\].*$//g;s/^.*\[//g' | awk -F':' '{print $1 " ore " $2 " minuti"}')" "$(calcurse --next | grep "\[" | sed 's/^.*[0-9]\]\s//g')"
