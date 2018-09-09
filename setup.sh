#!/bin/zsh

# git submodule status is slow...
if [[ `grep submodule .git/config | wc -l` == 0 ]] ; then
    git submodule init --update
fi

cd $(dirname $0)
for dotfile in .?* 
do
       if [ $dotfile != '..' ] && [ $dotfile != '.git' ] ; then
           ln -Ffs "$PWD/$dotfile" $HOME
       fi
done

ln -Ffs "$HOME/.config/nvim" "$HOME/dotfiles/nvim"

which brew &> /dev/null
if [[ $? > 0 ]]; then 
    echo 'installing homebrew'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap Homebrew/bundle
fi

brew tap Homebrew/bundle
brew bundle

which rbenv &> /dev/null
if [[ $? > 0 ]]; then
    echo 'installing rbenv'
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    exec $SHELL -l
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

which ndenv &> /dev/null
if [[ $? > 0 ]]; then
    echo 'installing ndenv'
    git clone https://github.com/riywo/ndenv ~/.ndenv
    exec $SHELL -l
fi

if [[ $SHELL != '/usr/local/bin/zsh' && -f '/usr/local/bin/zsh' ]]; then
    chsh -s /usr/local/bin/zsh
fi

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install


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
