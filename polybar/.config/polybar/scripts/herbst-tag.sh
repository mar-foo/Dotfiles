#!/bin/env bash
for x in $(herbstclient tag_status | sed "s/\t/\n/g;s/\s$//g" | grep ":" | cut -d: -f2); do
	echo " $x" > ~/.config/polybar/scripts/tag.txt
done
cat ~/.config/polybar/scripts/tag.txt
