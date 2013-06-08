export NODE_PATH=/usr/local/lib/node_modules

autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# switch color option available. Linux (ls --color), or BSD (ls -G)
ls --color -d . &>/dev/null 2>&1 && alias ls='ls --color=tty' || alias ls='ls -G'

## Prompt

# when $EDITOR is set to "vim", terminal shortcut keys 
# like Ctrl-a/Ctrl-k/Ctrl-r/Ctrl-s aren't available.
bindkey -e

# eval variable reference in prompt
setopt prompt_subst
# collection
setopt correct

## Directory

# cd with dir name only
setopt auto_cd
# eval path in variable for auto_cd
setopt cdablevars
# pushd on cd, come back with cd -[TAB]
setopt auto_pushd

# allow multiple redirect
setopt multios

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt share_history
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

# terminal tools

# rbenv init prepends rbenv's path, so guard against tmux sub-shell
if [[ -z $TMUX ]];then
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
fi

[[ -s /etc/profile.d/autojump.zsh ]] && source /etc/profile.d/autojump.zsh
[[ -s `brew --prefix`/etc/autojump.zsh ]] && source `brew --prefix`/etc/autojump.zsh

[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
