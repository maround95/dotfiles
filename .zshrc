# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# can add to path like so
path+=("${HOME}/.local/bin")

### Aliases ###
# no need to expand $HOME, the shell will do it for us
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias rm='rm -I'

ZSH_THEME="robbyrussell"

plugins=(
#  git
)

source $ZSH/oh-my-zsh.sh

# Vi Mode
bindkey -v

# Autocompletion only one enter
bindkey -M menuselect '^M' .accept-line
unsetopt BASH_AUTO_LIST
