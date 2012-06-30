" pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


" ===================
" colors, appearance
" ===================

" solarized
"let g:solarized_termcolors=256
"syntax enable
"set background=dark
"colorscheme solarized

" molokai

set background=dark
colorscheme molokai
let g:molokai_original = 1
syntax enable

" ===================
" syntax, indent
" ===================

set nocompatible
set smartindent
"set autoindent

filetype indent on

" ===================
" key mapping
" ===================

nnoremap <Tab> gt
nnoremap <S-Tab> gT


" ///////////// Plugins ////////////

" ===================
" commentary
" ===================
autocmd FileType ruby set commentstring=#\ %s


" ===================
" vim powerline
" ===================

set nocompatible   " Disable vi-compatibility
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors

set encoding=utf-8
set expandtab
set tabstop=2
set shiftwidth=2   " autoindent size
