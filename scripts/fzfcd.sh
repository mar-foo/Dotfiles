#!/bin/sh
# Author: Mario Forzanini https://marioforzanini.com
# Date: 16/05/2021
# Description: Wrapper around fzf used to easily change directory
# Dependencies: fzf
# Note: to change current directory you need to source the script, executing
# it will cause it to run in a subshell therefore leaving terminal's
# environment unchanged

# prevdir=$PWD
# cd $HOME
export FZF_DEFAULT_COMMAND='find ~ -type f'
new_dir=$(fzf --border=rounded --reverse --algo=v1 --height=30% | xargs -r dirname)
test -z $new_dir || cd $new_dir
return
