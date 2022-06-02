#!/bin/sh
abduco_running=$(abduco | grep dvtm)

if ! -z $abduco_running; then
	st -e "/bin/sh -c 'abduco -a dvtm'"
else
	st -e "abduco -c dvtm"
fi
