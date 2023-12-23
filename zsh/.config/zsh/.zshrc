#zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

_source_if_exists $ZDOTDIR/zim.zsh
_source_if_exists $ZDOTDIR/path.zsh
_source_if_exists $ZDOTDIR/aliases.zsh
_source_if_exists $ZDOTDIR/options.zsh
_source_if_exists $ZDOTDIR/envs.zsh
_source_if_exists $ZDOTDIR/p10k.zsh

#zprof
