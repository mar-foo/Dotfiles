#!/bin/sh
if [[ $(herbstclient attr clients.focus.class) = "Tor Browser" ]]; then
	herbstclient chain , close_and_remove , use_previous
else
	herbstclient close_or_remove
fi

