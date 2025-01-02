#!/usr/bin/env zsh

eval "$(starship init zsh)"
# completion
# TODO: add zsh completion
# fpath=($HOME/dotfiles/zsh/completion $fpath)
autoload -U compinit && compinit

eval "$(zoxide init zsh)"
#eval "$(anyenv init -)"
eval "$(mise activate zsh)"


# History settings
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

# Ensure history directory exists
[[ -d "${HISTFILE:h}" ]] || mkdir -p "${HISTFILE:h}"


setopt EXTENDED_HISTORY       # Saves timestamp and duration
setopt HIST_IGNORE_ALL_DUPS  # Keeps history clean of duplicates
setopt HIST_IGNORE_SPACE     # Doesn't save commands starting with space
setopt INC_APPEND_HISTORY    # Saves commands immediately
setopt SHARE_HISTORY         # Shares history across sessions

# this also fix control key related shortcuts(like ctrl-a/e) doesn't work propery
# in tmux
# c.f https://superuser.com/questions/523564/emacs-keybindings-in-zsh-not-working-ctrl-a-ctrl-e
# https://superuser.com/questions/523564/emacs-keybindings-in-zsh-not-working-ctrl-a-ctrl-e
bindkey -e
