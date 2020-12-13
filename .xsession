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
#Put monitor on the left
screen=$(xrandr | grep HDMI-A-0 | sed "s/ /;/g" | awk -F';' '{print $2}')

case $screen in
	"connected")xrandr --output eDP --primary --mode 1366x768 --pos 1920x163 --rotate normal --output HDMI-A-0 --mode 1920x1200 --pos 0x0 --rotate normal;;
	*);;
esac

#Set wallpaper and start compositor
nitrogen --restore
compton &
##SET DWM BAR##

#Functions
#dat(){
#dat=$(date +"%a, %d %b - %H:%M")
#echo -e $dat
#}

#bat(){
	#battery=$(cat /sys/class/power_supply/BAT0/capacity)
	#status=$(cat /sys/class/power_supply/BAT0/status)
	##if [[ $status = "Discharging" ]]; then 
		#echo "$battery%"
	#else 
		#echo "↑ $battery%"
	##fi
#}	

#while (true); do
#curl wttr.in/Palosco?format='%C+%t' > /home/mario/.local/bin/wheather_temp.txt
#sleep 3600s
#done &
##while (true); do
	#df -H | grep sda5 | sed "s/sda5/sda5;/g ; s/G/G;/g ; s/\s*//g" | awk -F';' '{print $4 "/" $2 " " 100-$3 "%"}' > /home/mario/.local/bin/disk.txt
	#sleep 600s
#done &	

#Loop to write on the bar
#while(true); do
##whtr=$(cat /home/mario/.local/bin/wheather_temp.txt)
#mem=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')
##disk=$(cat /home/mario/.local/bin/disk.txt)
#xsetroot -name " $disk | $whtr | $mem | $(bat) | $(dat)"
	#sleep 10s
#done &

#Exec screenlocker script in the background#
#lockscreen &

#Start dwm
#exec dwm

