#!/bin/bash
if [[ $(bsp-layout get $(bspc query -D -d focused --names)) == tall ]]; then
	bsp-layout remove
else
	bsp-layout set tall -- --master-size 0.5
fi
