#
#~/.bashrc
#

#If not running interactively, don't do anything
[[ $- != *i* ]] && return

##ALIASES##
alias abook='gpg -d /home/mario/.abook/addressbook.gpg > /home/mario/.abook/addressbook && abook'
alias f='fzf -e --height=10% --layout=reverse'
alias fwh='echo "Changing firewall zone to home..." ; sudo firewall-cmd --change-interface=wlp2s0 --zone=home'
alias fwp='echo "Changing firewall zone to public..." ; sudo firewall-cmd --change-interface=wlps20 --zone=public'
alias fww='echo "Changing firewall zone to work..." ; sudo firewall-cmd --change-interface=wlps20 --zone=work'
alias fz='fzfcmd=$(fzf -e --height=10% --layout=reverse) && xdg-open "$fzfcmd"'
alias ls='lsd -a --group-dirs=first --color=always'
alias ll='lsd -l --group-dirs=first --color=always'
alias la='lsd -a --group-dirs=first --color=always'
alias lla='lsd -la --group-dirs=first --color=always'
alias mocp='mocp --config /home/mario/.moc/.config'
alias neomutt='mw -Y && neomutt'
alias p='sudo pacman'
alias pvpn='sudo protonvpn'
alias :q='exit'
alias smci='sudo make clean install'
alias sxiv='devour sxiv'
alias vim='nvim'
alias v='vifmrun ~/Documents/University ~'
alias yt='/usr/local/bin/youtube-dl -x -f bestaudio'

#Path
export PATH="$HOME/.local/bin/scripts:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin/icecat:$PATH"

EDITOR=$"nvim"
VISUAL=$"nvim"
TERMINAL=$"st"
#Autostart
neofetch
#cowsay -f gnu "I'd just like to interject for a moment. What you are referring to as Linux, is in fact, GNU/Linux, or as I've recently taken to calling it, GNU plus Linux"
#unix

##PROMPT##
export PS1=" \W ∫ "
#Vi mode
set -o vi

#Fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

##USE ROOT##
source ~/root/bin/thisroot.sh
