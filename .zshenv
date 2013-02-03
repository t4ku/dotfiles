# Customize to your needs...
# rbenv/bind isn't necessary for brew installation
export PATH=$HOME/dotfiles/bin:/usr/local/bin:$PATH

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
