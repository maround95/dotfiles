# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# can add to path like so
path+=("${HOME}/.local/bin")

### Aliases ###
# no need to expand $HOME, the shell will do it for us
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias rm='rm -I'
alias ghci='stack ghci'

ZSH_THEME="robbyrussell"

plugins=(
#  git
)

source $ZSH/oh-my-zsh.sh

# Vi Mode
bindkey -v
bindkey "\E[32;2u" vi-cmd-mode

# Enable reverse search
bindkey "^R" history-incremental-search-backward

# Visual mode in zsh -> edit long commands in nvim
export EDITOR=/usr/bin/nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Autocompletion only one enter
bindkey -M menuselect '^M' .accept-line
unsetopt BASH_AUTO_LIST
