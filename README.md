dotfiles
=======

Install
-------

```bash
# clone this repo
> git clone https://github.com/t4ku/dotfiles.git

# initialize submodule
> git submodule init

# checkout files
> git submodule update


> ./setup.sh
```

* setup shell tries to create symlink from oh-my-zsh installation path(dotfiles/oh-my-zsh) to zsh/oh-my-zsh/custom
* put machine specific settings in zsh/local.zsh

### additional stuff

* Homebrew
  * tig
    * terminal git log viewer
  * zsh 5.0
    * better zsh completion on large git repos
  * [autojump](https://github.com/joelthelion/autojump/)
    * zshrc enable the command if installed
  * [homebrew-macvim](https://github.com/ryuk/homebrew-macvim)
    * macvim with project browser
  * node
  * [ack!](http://betterthangrep.com/)
    * better grep
* custom installer
  * iterm2
    * set "Left option key act as +esc" to use Meta Keys(M-) in tmux
  * npm
    * add rbenv settings to ~/.powconfig
    * export PATH=/usr/local/Cellar/rbenv/0.3.0/shims:/Users/:/usr/local/Cellar/rbenv/0.3.0/bin:$PATH
  * pow
    * depends on node/npm

Notes
-----

### adding vim plugin
----

```bash
git submodule add https://github.com/kien/ctrlp.vim.git .vim/bundle/ctrlp.vim
git commit
```

### fixing vim colorscheme

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
