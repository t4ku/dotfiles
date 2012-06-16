dotfiles
=======

Install
-------

### dependency

install oh-my-zsh

```bash
# clone this repo
> git clone https://github.com/t4ku/dotfiles.git

# create symlink
> ./setup.sh

# initialize submodule
> git submodule init

# checkout files
> git submodule update
```

Notes
-----

### adding vim plugin
----

```bash
git submodule add https://github.com/kien/ctrlp.vim.git .vim/bundle/ctrlp.vim
git commit
```
