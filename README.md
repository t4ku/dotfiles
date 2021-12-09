dotfiles
=======

Requirements
------------

* Command Line Tools for Xcode(```xcode-select --install```)

Install
-------

```bash
# clone this repo
> git clone https://github.com/t4ku/dotfiles.git
> ./setup.sh
```

### Manual setup

Below are the tools I use which needs mannual installation or setup.

- iterm2
  - set "Left option key act as +esc" to use Meta Keys(M-) in tmux
- Colorschemes
  - https://github.com/mbadolato/iTerm2-Color-Schemes
  - https://github.com/sonph/onehalf
    - Italic comment in tmux
      - https://github.com/sonph/onehalf/pull/101
- Cask
  - https://github.com/cask/cask
  - cask.el resides in ~/.emacs.d/elpa/xx.x/cask/cask.el

Notes
---------

### install additional components

```
# programming languages
brew bundle --file Brewfile.langs
```

### Hammerspoons

```
hs ./script.lua
```

- scripts needs to starts with './' or safe prefix
- add `-i` options to stay within hs prompt
