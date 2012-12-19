
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

set background=dark
colorscheme railscasts

set number

	
set list
" set listchars=eol:¬,tab:▻⠂
set listchars=eol:¬,tab:▸⠂
"set listchars=eol:¬,tab:▹⠂

set incsearch
set hlsearch

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

let mapleader = ","

nnoremap <Tab> gt
nnoremap <S-Tab> gT

" ===================
" mouse, clipboard
" ===================
 
" fixed using brew install reattach-to-usernamespace
" Fix Vim + Tmux yank/paste on unnamed register
" http://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
"if $TMUX== ""
  set clipboard=unnamed,autoselect
"endif

set mouse=a

" toggole paste/nopaste
noremap <Leader>v :set invpaste<CR>:set paste?<CR>

" copy filepath to clipboard
" from https://github.com/taku-o/vim-copypath/blob/master/plugin/copypath.vim
noremap <Leader>yp :let @*=expand('%:p')<CR> " yank full path
noremap <Leader>yf :let @*=expand('%:t')<CR> " yank file name


" ===================
" gui options
" ===================

set guioptions-=T  " hide toolbar
set showtabline=2  " always show tablines
set guifont=Monaco:h13

" ==================
" special chars
" ==================

set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

set expandtab
set tabstop=4
set shiftwidth=4   " autoindent size
set backspace=2    " use delete key to go back to previous line

" ==================
" Window
" ==================

if bufwinnr(1)
  nmap + <C-W>+
  nmap - <C-W>-
  nmap < <C-W><
  nmap > <C-W>>
endif 

" ===================
" misc
" ===================

set noswapfile     " disable swap file creation

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




" ==================== 
" tagbar
" ==================== 

nnoremap <silent> rt :TagbarToggle<CR>

if has("mac")
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
endif

"" Extending tabar to support markdown (additionally to the ~/.ctags-file!)
if executable('marktag')
    let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'ctagsbin' : 'marktag',
        \ 'kinds' : [
            \ 'h:header'
        \ ],
        \ 'sro' : '.',
        \ 'kind2scope' : {
            \ 'h' : 'header'
        \  },
        \ 'scope2kind' : {
            \ 'header' : 'h'
        \ }
    \ }
end

"" hide variable from default
""        \ 'v:variables',
let g:tagbar_type_php  = {
    \ 'ctagstype' : 'php',
    \ 'kinds'     : [
        \ 'i:interfaces',
        \ 'c:classes',
        \ 'd:constant definitions',
        \ 'f:functions',
        \ 'j:javascript functions:1'
    \ ]
  \ }


" ===================
" ctrl-p
" ===================

let g:ctrlp_map = '<Leader>c' 

let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 30
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_switch_buffer = 2

nnoremap <Leader>b :CtrlPBufTag<CR> 
nnoremap <Leader>B :CtrlPBuffer<CR> 
nnoremap <Leader>t :CtrlPTag<CR> 

" buftag ctag option
let g:ctrlp_buftag_types = {'php': '--language-force=php --php-types=cdfi'}

" ===================
" NERDTree
" ===================

nnoremap <Leader>n :NERDTreeToggle<CR>

" https://github.com/kien/ctrlp.vim/issues/78
let g:ctrlp_reuse_window = 'NERD_tree_2'

" ///////////// Misc ////////////

" =====================
" local setting
" ====================

if filereadable(expand('~/dotfiles/local/.vimrc.local'))
    source ~/dotfiles/local/.vimrc.local
endif

" ======================
" reload vimrc on change
" ======================

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
