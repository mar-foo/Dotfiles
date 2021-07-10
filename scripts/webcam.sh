#!/bin/sh
#choice=$(printf  "Begin\nEnd\nTest" | dmenu -c -l 2 -g 2 -i -p "Canon: ")
case $1 in
	"Begin") gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0 &
		;;
	"End") killall ffmpeg
		;;
	"Test")  gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0 &
		mpv av://v4l2:/dev/video0
		;;
esac
