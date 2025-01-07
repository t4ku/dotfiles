#!/usr/bin/env zsh

eval "$(starship init zsh)"

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


######################################
# fzf setup
######################################

if type brew &>/dev/null; then
  if [[ -d $(brew --prefix)/opt/fzf ]]; then
    # Set up fzf key bindings and fuzzy completion
    eval "$(fzf --zsh)"
  fi
fi

# Base fzf configuration - no preview to keep it simple and fast
# export FZF_DEFAULT_OPTS="
#   --height 40% 
#   --layout=reverse 
#   --border
#   --prompt='❯ '
#   --color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
#   --info=inline
#   --multi
#   --bind '?:toggle-preview'
#   --bind 'ctrl-a:select-all'
#   --bind 'ctrl-e:deselect-all'
#   --bind 'ctrl-t:toggle-all'
# "

# CTRL-T - Paste the selected files and directories onto the command-line
export FZF_CTRL_T_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="
  --preview='head -n 100 {}'
  --preview-window='right:hidden:wrap'
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-x:execute-silent(echo -n {+} | pbcopy)'
"

# CTRL-R - Paste the selected command from history onto the command-line
export FZF_CTRL_R_OPTS="
  --preview='echo {}'
  --preview-window=down:3:hidden:wrap
  --bind='ctrl-/:toggle-preview'
  --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'
"

# ALT-C - cd into the selected directory
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="
  --preview='tree -C {} | head -100'
  --bind='ctrl-/:toggle-preview'
"

# completion
# TODO: add zsh completion
# fpath=($HOME/dotfiles/zsh/completion $fpath)
autoload -U compinit && compinit
