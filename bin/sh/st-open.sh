#!/bin/sh

xidfile="$HOME/.cache/tabbed-st.xid"

runtabbed() {
	tabbed -c -dn tabbed-st -r 2 st -w '' >"$xidfile" \
		2>/dev/null &
}

if [ ! -r "$xidfile" ];
then
	runtabbed
else
	xid=$(cat "$xidfile")
	xprop -id "$xid" >/dev/null 2>&1
	if [ $? -gt 0 ];
	then
		runtabbed
	else
		st -w "$xid" >/dev/null 2>&1 &
	fi
fi

