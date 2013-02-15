if [[ -z $TMUX ]]; then
    export PATH=$HOME/dotfiles/bin:/usr/local/bin:$PATH
    #if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
    
else        
fi

if [[ -f "$HOME/dotfiles/local/local.zsh" ]];then
  source $HOME/dotfiles/local/local.zsh
fi
