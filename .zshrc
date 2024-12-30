#!/usr/bin/env zsh

eval "$(starship init zsh)"
# completion
# TODO: add zsh completion
# fpath=($HOME/dotfiles/zsh/completion $fpath)
autoload -U compinit && compinit

eval "$(zoxide init zsh)"
eval "$(anyenv init -)"
