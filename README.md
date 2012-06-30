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

# create symlink
> ./setup.sh
```

* setup shell tries to create symlink from oh-my-zsh installation path(dotfiles/oh-my-zsh) to zsh/oh-my-zsh/custom
* put machine specific settings in zsh/local.zsh

### additional stuff

* [autojump](https://github.com/joelthelion/autojump/)
 * zshrc enable the command if installed


Notes
-----

### adding vim plugin
----

```bash
git submodule add https://github.com/kien/ctrlp.vim.git .vim/bundle/ctrlp.vim
git commit
```
