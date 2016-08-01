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

#### custom installer

* iterm2
  * set "Left option key act as +esc" to use Meta Keys(M-) in tmux

### fixing vim colorscheme

#### molokai

[A patch to molokai.vim](https://gist.github.com/3351367)

```
hi Normal          ctermfg=252 ctermbg=none
```

#### railscasts

```
-call s:highlight("SpecialKey", "NONE", 13, "NONE")
+call s:highlight("SpecialKey", 8, "NONE", "NONE")
```

### clilpboard support macvim from inside tmux

```
brew info reattach-to-user-namespace
```

Notes
---------

### install additional components

```
# programming languages
brew bundle --file Brewfile.langs
```

### adding vim plugin

```bash
git submodule add https://github.com/kien/ctrlp.vim.git .vim/bundle/ctrlp.vim
git commit
```

### Avoid tmux sub-shell sourcing zprofile/zshenv/zshrc

Tmux starts sub-shell in opening/spliting windows/panes, sourcing zprofile/zshenv/zshrc.
So if your scripts add environment variables(mainly PATH), they are prepended twice in 
new windows/pane.

There's no way preventing tmux from sourcing scripts AFAIK.
But, the following fix worked for me.

https://github.com/rbenv/rbenv/issues/369#issuecomment-22200587

```
# /etc/zshenv
if [ -x /usr/libexec/path_helper ]; then
  PATH="" # Add this line
  eval `/usr/libexec/path_helper -s`
fi
```
