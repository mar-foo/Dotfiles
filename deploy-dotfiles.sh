#!/bin/sh
# Author: Mario Forzanini https://marioforzanini.com
# Date: 14/04/2021
# Description: Script used to deploy my dotfiles with GNU Stow
# Dependencies: GNU Stow
# If you want to deploy dwm.desktop and startdwm scripts where I chose to put them you will need root privileges

# Where to find dotfiles, where to deploy suckless software and wallpapers
test -z $SUCKLESS_DIR && SUCKLESS_DIR="$HOME/Github"
test -z $WALLPAPER_DIR && WALLPAPER_DIR="$HOME/Media/Pictures"
test -z $SCRIPTS_DIR && SCRIPTS_DIR="$HOME/.local/bin"

#Deploy my personal scripts to ~/.local/bin/scripts
deploy_scripts() {
    echo "Deploying scripts"
    stow -t $SCRIPTS_DIR scripts
    echo "Done."
}

# Deploy suckless software in $SUCKLESS_DIR/suckless
deploy_suckless() {
    suck_sw="dmenu dmenu1 dwm dwm1 slock st surf tabbed"
    for x in ${suck_sw}; do
	stow -t $SUCKLESS_DIR $x
	echo "Deploying $x in $SUCKLESS_DIR/suckless"
	done 
    echo "Done."
}

# Deploy configs in ~/.config
deploy_config() {
    configs="bspwm calcurse herbsluftwm	htop msmtp mutt newsboat openbox polybar sxhkd vifm"
    dotfiles=" .vimrc .bashrc .zshrc"
    
    for x in ${configs}; do
		test -z "$x" || continue
		stow -t "/home/mario" "$x"
		echo "Deploying $x configuration files to ~/.config"
	done
    for x in ${dotfiles}; do
		test -z "$x" || continue
		stow -t "/home/mario" "$x"
		echo "Deploying $x in ~"
	done
    echo "Done."
}

# Deploy wallpapers in $WALLPAPER_DIR/wallpapers
deploy_wallpaper() {
    echo "Deploying wallpapers"
    stow -t $WALLPAPER_DIR wallpapers
    echo "Done."
}

# Deploy files needed to setup a dwm session in the display manager
deploy_dwm() {
    echo "Deploying dwm.desktop and startdwm to /usr/share/xsessions/dwm.desktop and /usr/bin/startdwm\nnow dwm should appear in the display manager"
    doas stow -t / xsessions
    doas stow -t / startdwm
    echo "Done."
}

# Deploy everything
deploy_all_dotfiles() {
    echo "Deploying everything"
    deploy_suckless ; deploy_config ; deploy_wallpaper; deploy_dwm
    echo "Done."
}

# Read command line options
# TODO Fix default actions
while getopts ":haSscwd" o; do case "${o}" in
				      h) printf "Usage:\n\n\tdeploy-dotfiles.sh [OPTIONS]\n\nAVAILABLE OPTIONS:\n\t-h:\t Display this message\n\t-a:\tInstall all dotfiles in the current folder \n\t-c:\tInstall only configs\n\t-d:\tInstall files necessary to use dwm with a display manager (requires root privileges)\n\t-s:\tInstall suckless software, accepts the destination as optional argument\n\t-S:\tInstall scripts, accepts the destination as optional argument\n\t-w:\tInstall wallpapers, accepts destination as optional argument\n\n"
					 ;;
				      a) deploy_all_dotfiles
					 ;;
				      c) deploy_config
					 ;;
				      d) deploy_dwm
					 ;;
				      s) deploy_suckless
					 ;;
				      S) deploy_scripts
					 ;;
				      w) deploy_wallpaper
					 ;;
				      *) printf "Invalid option: -%s\\nTry -h for help\n" "$OPTARG" && exit 1;;
				  esac
done
