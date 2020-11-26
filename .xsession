#!/bin/bash
#set keyboard layout
setxkbmap it &

compton &

#Put monitor on the left
screen=$(xrandr | grep HDMI-A-0 | sed "s/ /;/g" | awk -F';' '{print $2}')

case $screen in
	"connected")xrandr --output eDP --primary --mode 1366x768 --pos 1920x163 --rotate normal --output HDMI-A-0 --mode 1920x1200 --pos 0x0 --rotate normal;;
	*);;
esac

#Set wallpaper and start compositor
xwallpaper --zoom ~/Downloads/wallpapers/arch-dark.png

##SET DWM BAR##

#Functions
dat(){
	dat=$(date +"%a, %d %b - %H:%M")
	echo -e $dat
}

while (true); do
	curl -H "Accept-Language: it" wttr.in/Palosco?format='%C+%t' > ~/bin/wheather_temp.txt
	sleep 3600s
done &

#Loop to write on the bar
while(true); do
whtr=$(cat ~/bin/wheather_temp.txt)
bat=$(cat /sys/class/power_supply/BAT0/capacity)
mem=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
xsetroot -name "$whtr | $mem | $bat% | $(dat)"
	sleep 10s
done &


#Start dwm
exec dwm

