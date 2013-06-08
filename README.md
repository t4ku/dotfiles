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

# link under home directory
> ./setup.sh
```

### Manual setup

Below are the tools I use which needs mannual installation or setup.

#### Homebrew

* rbenv
  * move /etc/zshenv to /etc/zprofile
  * change zprofile contents to prevent it from being loaded in tmux session(see Notes)
* tig
  * terminal git log viewer
* zsh 5.0
  * better zsh completion on large git repos
* [autojump](https://github.com/joelthelion/autojump/)
  * zshrc enable the command if installed
* [homebrew-macvim](https://github.com/ryuk/homebrew-macvim)
  * macvim with project browser
* [ack!](http://betterthangrep.com/)
  * better grep

#### custom installer

* iterm2
  * set "Left option key act as +esc" to use Meta Keys(M-) in tmux
* pow
  * depends on node/npm
* nvm(node.js)
  * install with install script (nvm)[https://github.com/creationix/nvm]

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

Misc
---------

### adding vim plugin
----

```bash
git submodule add https://github.com/kien/ctrlp.vim.git .vim/bundle/ctrlp.vim
git commit
```

### Avoid tmux sub-shell sourcing zprofile/zshenv/zshrc

Tmux starts sub-shell in opening/spliting windows/panes, sourcing zprofile/zshenv/zshrc.
So if your scripts add environment variables(mainly PATH), they are prepended twice in 
new windows/pane.

There's no way preventing tmux from sourcing scripts AFAIK.
I ended up adding if statement skipping export env variable 
when called from tmux.

```
if [[ -z $TMUX ]]; then
    export PATH=/some/path;"$PATH"
fi
```
Since sub-shell also source /etc/zshenv or /etc/zprofile,
you also need to edit them.

```
if [[ -z $TMUX ]] && [ -x /usr/libexec/path_helper ]; then
	eval `/usr/libexec/path_helper -s`
fi
```
