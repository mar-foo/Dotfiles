#!/bin/sh

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

 start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#Autostart
screen=$(xrandr | grep HDMI-A-0 | sed "s/ /;/g" | awk -F';' '{print $2}')

#if ($(scr())=="connected")
#	xrandr --output eDP --primary --mode 1366x768 --pos 1920x174 --rotate normal --output HDMI-A-0 --mode 1920x1200 --pos 0x0 --rotate normal
#	xwallpaper --zoom ~/Downloads/arch-dracula.png
#else
#	xwallpaper --zoom ~/Downloads/arch-dracula.png
#fi


#Put monitor on the left
case $screen in
	"connected")xrandr --output eDP --primary --mode 1366x768 --pos 1920x163 --rotate normal --output HDMI-A-0 --mode 1920x1200 --pos 0x0 --rotate normal;;
	*);;
esac

#Set wallpaper and start compositor
xwallpaper --zoom ~/Downloads/wallpapers/arch-dark.png
compton &

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


##RUN WINDOW MANAGER##

exec dwm



