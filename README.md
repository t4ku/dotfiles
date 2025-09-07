# dotfiles

## Setup

## Downloads

Pick Noto.zip and install `Nerd Font Mono`
https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Noto#tldr
https://github.com/ryanoasis/nerd-fonts/releases

## prompts

```
find . -type f -not -path "./.git/**" -not -path "**/*.log" -not -path "./prompts*" -not -path "**/*/plugins/*" -not -path "**/*.png"  -not -path ".jpg" -not -path "./alacritty/themes/*"  -exec sh -c 'echo "\n=== {} ==="; cat {}' \; > prompts/config.txt
```

## ToDo

- powerline
  - [ ] use tmuxline/vim lightweight powerine plugin(like airline/lualine..etc), and use the same color
  - [ ] add items from tmux-powerline in tmux
