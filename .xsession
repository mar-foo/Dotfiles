#!/bin/bash
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

#Caps lock is escape when pressed, super when held down
xcape -e 'Super_L=Escape'

#Put monitor on the left
screen=$(xrandr | grep VGA-1 | sed "s/ /;/g" | awk -F';' '{print $2}')
case $screen in
	"connected") resolution=$(xrandr | grep VGA-1 | sed 's/ /;/g' | awk -F';' '{print $3}' | sed 's/\+.*$//g')
		case $resolution in
			1920x1200) xrandr --output VGA-1 --left-of LVDS-1;;
			1280x1024) xrandr --output VGA-1 --above LVDS-1;;
			*);;
		esac;;
	*);;
esac

