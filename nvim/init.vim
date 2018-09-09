set termguicolors


" ===================
" PlugIns
" ===================

call plug#begin()

Plug 'jacoborus/tender.vim'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

call plug#end()

" ===================
" colorscheme
" ===================
"
colorscheme tender

" ===================
" ctrl-p
" ===================


let g:ctrlp_map                 = '<Leader>c'

let g:ctrlp_working_path_mode   = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_height          = 30
let g:ctrlp_extensions          = ['tag', 'buffertag']
let g:ctrlp_switch_buffer       = 2
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

nnoremap <Leader>b :CtrlPBufTag<CR> 
nnoremap <Leader>B :CtrlPBuffer<CR> 
nnoremap <Leader>t :CtrlPTag<CR> 

" ===================
" key mapping
" ===================

let mapleader = ","
