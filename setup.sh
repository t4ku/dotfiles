#!/bin/zsh

# Set XDG variables if they are not already set.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

DOTFILES=(
    .zshrc
    .zshenv
    .zprofile
    .gitconfig
    .tmux.conf
)

DOTCONFIGS=(
    #hammerspoon
    alacritty
    nvim
    tmux
    fzf
    mise
    tmux-powerline
)

cd $(dirname $0)



# Create symbolic links for dotfiles
for dotfile in "${DOTFILES[@]}"; do
       if [ $dotfile != '..' ] && [ $dotfile != '.git' ] ; then
           ln -Ffs "$PWD/$dotfile" $HOME
       fi
done

ln -Ffs "$PWD/starship.toml" "$XDG_CONFIG_HOME/starship.toml"

# Create config links for all config in XDG
echo "Creating symbolic links for config in XDG"
for config in "${DOTCONFIGS[@]}"; do
  target_dir="$XDG_CONFIG_HOME/$config"
  source_dir="$PWD/$config"

  # Check if the source directory exists
  if [ -d "$source_dir" ]; then
    # Remove the target if it exists and is a symlink to avoid loops
    if [ -L "$target_dir" ]; then
      echo "Removing existing symlink: $target_dir"
      rm "$target_dir"
    fi

    # Create the parent directory if it doesn't exist
    if [ ! -d "$(dirname "$target_dir")" ]; then
      echo "Creating directory: $(dirname "$target_dir")"
      mkdir -p "$(dirname "$target_dir")"
    fi

    # Create a new symlink if the target doesn't exist or is not a symlink
    if [ ! -e "$target_dir" ] || [ ! -L "$target_dir" ]; then
      echo "Linking directory $source_dir -> $target_dir"
      ln -s "$source_dir" "$target_dir"
    else
      echo "Symlink already exists: $target_dir"
    fi
  else
    echo "Source directory does not exist: $source_dir"
  fi
done

# https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# SSH config setup
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Create base SSH config if it doesn't exist
if [ ! -f ~/.ssh/config ]; then
    cat > ~/.ssh/config << 'EOL'
# Default GitHub
Host github.com
    HostName github.com
    User git
    IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    IdentitiesOnly yes

# Example: GitHub Enterprise/Work Account
# Host github.com-work
#     HostName github.com
#     User git
#     IdentitiesOnly yes
#     IdentityFile ~/.ssh/public-key-downloaded-from-1password.pub
EOL
    chmod 600 ~/.ssh/config
fi

#
## config
#ln -Ffs "$HOME/.config/nvim" "$HOME/dotfiles/nvim"

## git submodule status is slow...
#if [[ `grep submodule .git/config | wc -l` == 0 ]] ; then
#    git submodule init --update
#fi
#
## dotfiles
##
#cd $(dirname $0)
#for dotfile in .?* 
#do
#       if [ $dotfile != '..' ] && [ $dotfile != '.git' ] ; then
#           ln -Ffs "$PWD/$dotfile" $HOME
#       fi
#done
#
## config
#ln -Ffs "$HOME/.config/nvim" "$HOME/dotfiles/nvim"
#
## vim-plug
#curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#
#
#which brew &> /dev/null
#if [[ $? > 0 ]]; then 
#    echo 'installing homebrew'
#    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#    brew tap Homebrew/bundle
#fi
#
#which cask &> /dev/null
#if [[ $? > 0 ]]; then
#    echo 'installing csk'
#    git clone https://github.com/cask/cask ~/.cask
#    # echo 'PATH=$HOME/.cask/bin:$PATH' >> .bashrc
#fi
#
#eval "$(/opt/homebrew/bin/brew shellenv)"
#brew bundle
#
#
#if [[ $SHELL != '/usr/local/bin/zsh' && -f '/usr/local/bin/zsh' ]]; then
#    chsh -s /usr/local/bin/zsh
#fi
#
#if [[ ! -d ~/.fzf ]]; then
#    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
#    ~/.fzf/install
#fi
#
#anyenv install pyenv
#anyenv install nodenv
#anyenv install rbenv
#
#eval "$(anyenv init -)"
#
#which pyenv virtualenv $> /dev/null
#if [[ $? > 0 ]]; then
#    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
#    # TODO:
#    # https://alpacat.com/blog/neovim-mac-pyenv
#fi
#
#if [[ ! -f '/usr/local/bin/limelight' ]]; then 
#  git clone https://github.com/koekeishiya/limelight ~/.limelight
#  cd ~/.limelight
#  make
#  sudo ln -s ./bin/limelight /usr/local/bin/limelight 
#fi
#
#echo 'stackline'
#if [[ ! -f '~/.hammerspoon/stackline' ]]; then
#  git clone https://github.com/AdamWagner/stackline.git ~/.hammerspoon/stackline
#  cd ~/.hammerspoon
#  echo 'stackline = require "stackline"' >> init.lua
#  echo 'stackline:init()' >> init.lua
#fi
#
#
## mitmproxy
## > mitmdump
## Ctrl-C
## # check cert is created
## > file ~/.mitmproxy/mitmproxy-ca-cert.pem
## # add keychain(login)
## > open ~/.mitmproxy/mitmproxy-ca-cert.pem
## # add pac file and set it in proxy(see proxy.pac.example)
## # make sure the file path scheme(file:///)
## > mitumdump
