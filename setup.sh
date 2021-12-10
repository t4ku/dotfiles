#!/bin/zsh
# exit imediately on error
set -e

# git submodule status is slow...
if [[ `grep submodule .git/config | wc -l` == 0 ]] ; then
    git submodule init --update
fi

# dotfiles
#
cd $(dirname $0)
for dotfile in .?* 
do
       if [ $dotfile != '..' ] && [ $dotfile != '.git' ] ; then
           ln -Ffs "$PWD/$dotfile" $HOME
       fi
done

# config
ln -Ffs "$HOME/.config/nvim" "$HOME/dotfiles/nvim"

# vim-plug
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


which brew &> /dev/null
if [[ $? > 0 ]]; then 
    echo 'installing homebrew'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap Homebrew/bundle
fi

which cask &> /dev/null
if [[ $? > 0 ]]; then
    echo 'installing csk'
    git clone https://github.com/cask/cask ~/.cask
    # echo 'PATH=$HOME/.cask/bin:$PATH' >> .bashrc
fi
brew bundle


if [[ $SHELL != '/usr/local/bin/zsh' && -f '/usr/local/bin/zsh' ]]; then
    chsh -s /usr/local/bin/zsh
fi

if [[ ! -d ~/.fzf ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

anyenv install pyenv
anyenv install nodenv
anyenv install rbenv

if [[ ! -f '/usr/local/bin/limelight' ]]; then 
  git clone https://github.com/koekeishiya/limelight ~/.limelight
  cd ~/.limelight
  make
  ln -s ./bin/limelight /usr/local/bin/limelight 
fi

echo 'stackline'
if [[ ! -f '~/.hammerspoon/stackline' ]]; then
  git clone https://github.com/AdamWagner/stackline.git ~/.hammerspoon/stackline
  cd ~/.hammerspoon
  echo 'stackline = require "stackline"' >> init.lua
  echo 'stackline:init()' >> init.lua
fi


# mitmproxy
# > mitmdump
# Ctrl-C
# # check cert is created
# > file ~/.mitmproxy/mitmproxy-ca-cert.pem
# # add keychain(login)
# > open ~/.mitmproxy/mitmproxy-ca-cert.pem
# # add pac file and set it in proxy(see proxy.pac.example)
# # make sure the file path scheme(file:///)
# > mitumdump
