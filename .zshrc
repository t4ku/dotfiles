export NODE_PATH=/usr/local/lib/node_modules

autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# switch color option available. Linux (ls --color), or BSD (ls -G)
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

# eval variable reference in prompt
setopt prompt_subst

# cd with dir name only
setopt auto_cd
# eval path in variable for auto_cd
setopt cdablevars
# allow multiple redirect
setopt multios
# collection
setopt correct

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload history-search-end

bindkey ^P  history-search-backward # search backward the history with current input
bindkey ^N  history-search-forward  # search forward the history with current input

# completion
fpath=($HOME/dotfiles/zsh/completion $fpath)
autoload -U compinit && compinit

# highlight selection
zstyle ':completion:*' menu select

PROMPT='%{$fg[yellow]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}
>> '

# alias
alias g="git"
alias gst="git status"

# tools
[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh
[[ -s `brew --prefix`/etc/autojump.zsh ]] && source `brew --prefix`/etc/autojump.zsh
