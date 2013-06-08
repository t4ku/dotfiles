if [[ -z $TMUX ]]; then

## base setting for all shells (login/non-login, interactive)
export EDITOR="vim"
export SVN_EDITOR=$EDITOR

# environment variable
export OS=`uname -s`
export ARCH=`uname -m`

# create nicer name
if [[ "$OS" == 'Darwin' ]];then
    PLATFORM='osx'
elif [[ "$OS" == 'Linux' ]];then
    PLATFORM='linux'
fi

export PLATFORM

# load platform specific ones
if [[ -f "$HOME/dotfiles/.zshenv.$PLATFORM" ]];then
    source "$HOME/dotfiles/.zshenv.$PLATFORM" 
fi


fi
