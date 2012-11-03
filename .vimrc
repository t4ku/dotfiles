" pathogen
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


" ===================
" colors, appearance
" ===================

syntax enable

" solarized
"set background=dark
"let g:solarized_termtrans=1
"colorscheme solarized
"
" molokai

set background=dark
colorscheme molokai
"let g:molokai_original = 1

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

" ==================== 
" tagbar
" ==================== 

nnoremap <silent> rt :TagbarToggle<CR>

if has("mac")
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
endif

"" Extending tabar to support markdown (additionally to the ~/.ctags-file!)
let g:tagbar_type_markdown = {
  \ 'ctagstype' : 'markdown',
  \ 'kinds' : [
    \ 'h:Heading_L1',
    \ 'i:Heading_L2',
    \ 'k:Heading_L3'
  \ ]
\ }

" ===================
" mouse, clipboard
" ===================
 
" fixed using brew install reattach-to-usernamespace
" Fix Vim + Tmux yank/paste on unnamed register
" http://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
"if $TMUX== ""
  set clipboard=unnamed,autoselect
"endif

" ===================
" gui options
" ===================

set guioptions-=T  " hide toolbar
set showtabline=2  " always show tablines
set guifont=Monaco:h13

