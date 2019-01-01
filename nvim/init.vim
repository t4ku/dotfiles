set termguicolors

set shell=$HOME/dotfiles/nvim/wrapper.sh

let mapleader = ","

set noswapfile

" Script
"let g:ruby_host_prog = "$HOME/.rbenv/shims/neovim-ruby-host"
let g:ruby_host_prog = expand('~/.rbenv/versions/2.2.10/bin/ruby')
" https://qiita.com/lighttiger2505/items/9a36c5b4035dd469134c
let g:python3_host_prog = expand('~/.pyenv/versions/bin/python')


" ===================
" PlugIns
" ===================

call plug#begin()

Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'tpope/gem-ctags'
Plug 'tpope/vim-bundler'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'othree/yajs.vim'
Plug 'slim-template/vim-slim'

autocmd FileType smarty let b:surround_{char2nr('=')} = "{? \r ?}"
autocmd FileType smarty let b:surround_{char2nr('-')} = "{?* \r *?}"

autocmd FileType eruby let b:surround_{char2nr('=')} = "<%= \r %>"
autocmd FileType eruby let b:surround_{char2nr('-')} = "<% \r %>"

Plug 'mattn/emmet-vim'

Plug 'w0rp/ale'

let g:ale_linters = {
\ 'python': ['flake8']
\}

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'python': ['autopep8', 'black', 'isort'],
\   'javascript': ['prettier', 'eslint']
\}
let g:ale_enabled = 1
"let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 1

let g:ale_ruby_rubocop_executable = expand('~/.rbenv/shims/rubocop')

" python
let g:ale_python_flake8_executable = expand('~/.pyenv/versions/neovim3/bin/flake8')
let g:ale_python_autopep8_executable = expand('~/.pyenv/versions/neovim3/bin/autopep8')
let g:ale_python_isort_executable = expand('~/.pyenv/versions/neovim3/bin/isort')
let g:ale_python_black_executable = expand('~/.pyenv/versions/neovim3/bin/black')

let g:ale_javascript_prettier_eslint_excutable = expand('./node_modules/.bin/prettier-eslint')
let g:ale_javascript_prettier_excutable = expand('./node_modules/.bin/prettier')
let g:ale_javascript_eslint_excutable = expand('./node_modules/.bin/eslint')

Plug 'junegunn/fzf.vim'
set rtp+=~/.fzf

nnoremap <Leader>c :Files<CR>
nnoremap <Leader>B :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>b :BTags<CR>

Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/tslime.vim'
Plug 'ervandew/supertab'

Plug 'lighttiger2505/gtags.vim'


" Align
"ZoomWin
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
" key mapping
" ===================


nnoremap gl :Gitv!<cr>

" this overrides jumps (CTRL-I # see :verbose map <C-i> )
nnoremap <Tab> gt
nnoremap <S-Tab> gT

nnoremap <leader>q :copen<cr>

" ===================
" NERDTree
" ===================

nnoremap <leader>nf :NERDTreeFind<cr>
nnoremap <leader>nd :NERDTreeToggle<cr>

" =====================
" vim-rspec
" =====================

let g:rspec_command = 'call Send_to_Tmux("spring rspec {spec}\n")'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" ==========
" clipboard
" ==========
"
set clipboard+=unnamedplus

" ===================
" colorscheme
" ===================
"
" colorscheme tender
set termguicolors

if (exists("$COLORFGBG"))
  if  split($COLORFGBG, ";")[0] == 15
    set background=dark
    "colorscheme railscasts
  else
    set background=light
    "colorscheme hemisu
    "colorscheme github
  endif
  colorscheme one
else
  "colorscheme railscasts
  "colorscheme jellybeans
  colorscheme hybrid
endif

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
" languages
" ===================

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" ===================
" misc
" ===================

" expand current directory in command
" http://stackoverflow.com/questions/2170340/vim-e-starting-directory
cnoremap <Leader>e <c-r>=expand("%:h")<cr>

" copy filepath to clipboard
" from https://github.com/taku-o/vim-copypath/blob/master/plugin/copypath.vim
noremap <Leader>yp :let @*=expand('%:p')<CR> " yank full path
noremap <Leader>yf :let @*=expand('%:t')<CR> " yank file name
