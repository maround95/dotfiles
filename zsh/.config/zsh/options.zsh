# Colors
autoload -U colors && colors

# Bindings
bindkey -v # Vi-mode
bindkey "^N" autosuggest-accept

# Visual mode in zsh -> edit long commands in nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

unsetopt BASH_AUTO_LIST

# select bracketed/quoted like vim
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km -- $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km -- $c select-bracketed
  done
done

# History
HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$HOME/.zshhistory"
setopt appendhistory
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space
