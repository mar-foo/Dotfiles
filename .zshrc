# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion::complete:*' use-cache 1
zstyle :compinstall filename '/home/mario/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=500
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
#

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

EDITOR=vim
VISUAL=vim
TERMINAL=st

#Prompt
export PS1="%1~ %(?..)
$ "

#PATH
export PATH="${HOME}/.local/bin/:${PATH}"
export PATH="${HOME}/.local/bin/scripts/:${PATH}"
export PATH="${PATH}:/opt/bin/plan9/"

source /home/mario/Github/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
