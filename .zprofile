export LANG=ja_JP.UTF-8

if [[ -z $TMUX ]]; then
    export PATH=$HOME/dotfiles/bin:$PATH

    if [[ -f "$HOME/dotfiles/local/local.zsh" ]];then
        source $HOME/dotfiles/local/local.zsh
    fi
else        
fi
#if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

