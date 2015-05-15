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

if [[ $SHELL != '/usr/local/bin/zsh' && -f '/usr/local/bin/zsh' ]]; then
    chsh -s /usr/local/bin/zsh
fi
