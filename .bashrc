#
#~/.bashrc
#

#If not running interactively, don't do anything
[[ $- != *i* ]] && return
#Aliases
alias ls='exa -la --group-directories-first --color=always'
alias p='sudo pacman'
alias v='vifm'
alias :q='exit'
alias smci='sudo make clean install'

#Path
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
#run fish
#fish
#Autostart
neofetch

##PROMPT##
export PS1=" \[\e[36m\]\W\[\e[m\] ∫  "

#Vi mode
set -o vi

