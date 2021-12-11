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
# turn off zle bracketed paste to prevent tmux commands from being messed up
# http://stackoverflow.com/questions/33452870/tmux-bracketed-paste-mode-issue-at-command-prompt-in-zsh-shell
(( $+TMUX )) && unset zle_bracketed_paste
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

alias npm-exec='PATH=$(npm bin):$PATH'

# global/gtags
export GTAGSLABEL=pygments

# terminal tools

export PATH="$HOME/.anyenv/bin:$HOME/.cask/bin:$PATH"
eval "$(anyenv init -)"
# for installing ruby < 2.4, you need to install openssl@1.0
# https://github.com/rbenv/ruby-build/wiki#openssl-version-compatibility
#export PATH="$HOME/.rbenv/bin:$PATH"
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
#[[ -s ~/.nvm/nvm.sh ]] && . ~/.nvm/nvm.sh
#if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
#if which plenv > /dev/null; then eval "$(plenv init -)"; fi


#eval "$(fasd --init auto)"

## ndenv
#export PATH="$HOME/.ndenv/bin:$PATH"
#eval "$(ndenv init -)"

#export PATH="$HOME/.embulk/bin:$PATH"

# load platform specific ones
if [[ -f "$HOME/dotfiles/.zshrc.$PLATFORM" ]];then
    source "$HOME/dotfiles/.zshrc.$PLATFORM" 
fi

after_zshrc

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [ -f ~/.fzf.zsh ]; then
   #source ~/.fzf.zsh
   source ~/dotfiles/.fzf.zsh
fi

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/takuokawa/.ndenv/versions/v6.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/takuokawa/.ndenv/versions/v6.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/takuokawa/.ndenv/versions/v6.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/takuokawa/.ndenv/versions/v6.9.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# direnv
eval "$(direnv hook zsh)"
