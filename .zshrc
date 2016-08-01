before_zshrc

autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export TERM=xterm-256color

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

# zle

autoload edit-command-line
zle -N edit-command-line
bindkey ^x^e edit-command-line
#bindkey -M vicmd v edit-command-line

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
alias gco="git checkout"

alias jxa="osascript -l JavaScript"

alias -g GB='`git branch -a | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# terminal tools

# rbenv init prepends rbenv's path, so guard against tmux sub-shell
if [[ -z $TMUX ]];then
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
    [[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
    if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
    if which plenv > /dev/null; then eval "$(plenv init -)"; fi
    export PATH=$HOME/.nodebrew/current/bin:$PATH
    eval "$(fasd --init auto)"
fi

# load platform specific ones
if [[ -f "$HOME/dotfiles/.zshrc.$PLATFORM" ]];then
    source "$HOME/dotfiles/.zshrc.$PLATFORM" 
fi

after_zshrc

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [ -f ~/.fzf.zsh ]; then
   source ~/.fzf.zsh
   source ~/dotfiles/.fzf.zsh
fi
