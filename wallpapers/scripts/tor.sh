#!/bin/bash
if [[ $(herbstclient tag_status | awk '{print $3}' | sed 's///g') = ":" ]]; then
	herbstclient chain , lock , use  , split right 0.5 , focus right , spawn torbrowser-launcher , unlock
else
	herbstclient chain , use  , spawn torbrowser-launcher
fi
