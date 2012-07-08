# Path to your oh-my-zsh configuration.
# change path to dotfiles git submodule
ZSH=$HOME/dotfiles/oh-my-zsh
# change custom dir accordingly
ZSH_CUSTOM=$HOME/dotfiles/zsh/oh-my-zsh/custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="philips"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(rbenv bundler git ruby)

source $ZSH/oh-my-zsh.sh

stty erase ^H
stty erase '^?'

export TERM=xterm-256color

# Customize to your needs...
# rbenv/bind isn't necessary for brew installation
export PATH=$HOME/.rbenv/bin:HOME.bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# 
if [[ -f "./zsh/local.zsh" ]];then
  source ./zsh/local.zsh
fi

# autojump
if [ -f `brew --prefix`/etc/autojump ]; then
    . `brew --prefix`/etc/autojump
fi
# 
unset SSH_ASKPASS
