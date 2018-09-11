set termguicolors


" ===================
" PlugIns
" ===================

call plug#begin()

Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'tpope/gem-ctags'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/tslime.vim'

" Align
"ZoomWin
"ack
"ag.vim
"ctrlp.vim
"emmet-vim
"fzf.vim
"gtags.vim
"jedi-vim
"jekkybeans
"nerdtree
"patchreview-vim
"seoul256
"smarty.vim
"summerfruit256.vim
"supertab
"syntastic
"tabular
"tagbar
"textile
"tlib_vim
"twilight256.vim
"vdebug-joonty
"vim-HiLinkTrace
"vim-abolish
"vim-addon-mw-utils
"vim-bundler
"vim-cocoa
"vim-commentary
"vim-cucumber
"vim-easymotion
"vim-elm
"vim-endwise
"vim-flake8
"vim-fugitive
"vim-github-colorscheme
"vim-hex-ghighlight
"vim-hybrid
"vim-javascript
"vim-linediff
"vim-lucius
"vim-markdown
"vim-over
"vim-pathogen
"vim-ragtag
"vim-rails
"vim-railscasts
"vim-rspec
"vim-rubocop
"vim-ruby
"vim-signature
"vim-slim
"vim-sqlutilities
"vim-surround
"vim-togglelist
"vim-ultisnips
"vim-ultisnips-snippets
"vim_ios


" colorschemes
"
Plug 'rakr/vim-one'
Plug 'jacoborus/tender.vim'

call plug#end()

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
" NERDTree
" ===================

nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader>nd :NERDTreeToggle<cr>

" =====================
" vim-rspec
" =====================

let g:rspec_command = 'call Send_to_Tmux("./bin/rspec {spec}\n")'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" ===================
" key mapping
" ===================

let mapleader = ","

nnoremap gl :Gitv!<cr>

" ==========
" clipboard
" ==========
"
set clipboard+=unnamedplus

" ===================
" colorscheme
" ===================
"
colorscheme tender

" ===================
" appearance
" ===================
"
set number
set listchars=eol:¬,tab:▸⠂

" ===================
" syntax, indent
" ===================

set nocompatible
set smartindent

" ===================
" misc
" ===================

" expand current directory in command
" http://stackoverflow.com/questions/2170340/vim-e-starting-directory
cnoremap <Leader>e <c-r>=expand("%:h")<cr>
