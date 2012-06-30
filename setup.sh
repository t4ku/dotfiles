#!/bin/sh

cd $(dirname $0)
for dotfile in .?* 
do
       if [ $dotfile != '..' ] && [ $dotfile != '.git' ] ; then
           ln -Fis "$PWD/$dotfile" $HOME
       fi
done

# oh-my-zsh
if [ -d 'oh-my-zsh/custom' ]; then
  if [ ! -L 'oh-my-zsh/custom' ]; then
    rm -rf 'oh-my-zsh/custom'
    ln -s zsh/oh-my-zsh/custom oh-my-zsh/custom
    # git doesn't mind symlink or dir
    cd oh-my-zsh;
    git checkout custom/example*
  fi
fi
