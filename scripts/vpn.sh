#!/bin/sh
command=$(echo "Connect\nDisconnect\nReload\nStatus" | dmenu -c -l 2 -g 2 -i -p "VPN:")
case "$command" in
	"Connect") sudo protonvpn c -f > ~/.local/bin/vpn.txt ; notify-send "VPN" "$(cat ~/.local/bin/vpn.txt)";;
	"Disconnect") sudo protonvpn d > ~/.local/bin/vpn.txt ; notify-send "VPN" "$(cat ~/.local/bin/vpn.txt)";;
	"Reload") sudo protonvpn r > ~/.local/bin/vpn.txt ; notify-send "VPN" "$(cat ~/.local/bin/vpn.txt)";;
	"Status") notify-send "VPN" "$(grep "ected" ~/.local/bin/vpn.txt)";;
	*) notify-send "Aborted";;
esac
