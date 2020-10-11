# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# can add to path like so
path+=("/media/d/Development/Android/Tools/path_tools_linux")
path+=("$HOME/.local/bin")
path+=("$HOME/.cargo/bin")

# set jupyter lab dir for user
export JUPYTERLAB_DIR=$HOME/.local/share/jupyter/lab

### Aliases ###
# no need to expand $HOME, the shell will do it for us
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias rm='rm -I'
alias ghci='stack ghci'
alias info='info --vi-keys'
alias fixpanel='qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "panels()[0].height = 40; panels()[0].height = 58"'
alias startwayland='XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland'

ZSH_THEME="robbyrussell"

plugins=(
#  git
)

source $ZSH/oh-my-zsh.sh
#source /etc/profile.d/conda.sh

# Vi Mode
bindkey -v

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
