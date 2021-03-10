#
#~/.bashrc
#

#If not running interactively, don't do anything
[[ $- != *i* ]] && return

##ALIASES##
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
alias pvpn='sudo protonvpn'
alias :q='exit'
alias sxiv='devour sxiv'
alias vim='vim'
alias v='vifmrun ~/Documents/University ~'
alias yt='/usr/local/bin/youtube-dl -x -f bestaudio'

#Path
export PATH="$HOME/.local/bin/scripts:$PATH"

EDITOR=$"vim"
VISUAL=$"vim"
TERMINAL=$"st"

#Autostart
#neofetch
unix

##PROMPT##
#export PS1=" \[\033[01;34m\] \W ∫\[\033[00m\] "
export PS1="\[\033[01;34m\] [\A] [\W] \n \$\[\033[00m\] "
#Vi mode
set -o vi

#Fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
