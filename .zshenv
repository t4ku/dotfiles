# local customization function prototype
before_zshenv(){}
after_zshenv(){}
before_zshrc(){}
after_zshrc(){}
before_zprofile(){}
after_zprofile(){}

# load functions
if [[ -f "$HOME/dotfiles/local/local.zsh" ]]; then
    source  "$HOME/dotfiles/local/local.zsh"
fi

#if [[ -z $TMUX ]]; then

    before_zshenv

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


    after_zshenv
#fi

# terminal vimrc dark
#export COLORFGBG='15;0'
# terminal vimrc light
#export COLORFGBG='0;15'
