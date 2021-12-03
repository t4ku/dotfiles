set termguicolors

set shell=$HOME/dotfiles/nvim/wrapper.sh

let mapleader = ","

set noswapfile

set expandtab
set tabstop=2

" Script
"let g:ruby_host_prog = "$HOME/.rbenv/shims/neovim-ruby-host"
let g:ruby_host_prog = expand('~/.rbenv/versions/2.2.10/bin/ruby')
" https://qiita.com/lighttiger2505/items/9a36c5b4035dd469134c
let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
"let g:node_host_prog = expand('~/.ndenv/versions/v10.13.0/bin/node')
"let g:node_host_prog = expand('~/.ndenv/shims/neovim-node-host')
let g:node_host_prog = expand('~/.ndenv/versions/v10.13.0/lib/node_modules/neovim/bin/cli.js')


" ===================
" PlugIns
" ===================

call plug#begin()

Plug 'buggo/gitv', {'on': ['Gitv']}
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'tpope/gem-ctags'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rhubarb'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'othree/yajs.vim'
Plug 'slim-template/vim-slim'
Plug 'hashivim/vim-terraform'
Plug 'ayu-theme/ayu-vim'
"Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'elmcast/elm-vim'
Plug 'evanleck/vim-svelte'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': '*' }
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

Plug 'mattn/vim-goimports'

Plug 'AndrewRadev/linediff.vim'
Plug 'vim-vdebug/vdebug'
" Plug 'vdebug-joonty'

let g:vdebug_options = {
\  'path_maps' : { '/home/vagrant/nfs_sync_dir/bm_php' : '/Users/takuokawa/Code/enigmo/buyma/jp/bm_dev_chef/nfs_sync_dir/bm_php' }
\  }


" http://stackoverflow.com/questions/5117991/vim-insert-empty-erb-tags
" <c-s>= to start(in terminal vim prefix with <c-g>s, yss= for existing
autocmd FileType smarty let b:surround_{char2nr('=')} = "{? \r ?}"
autocmd FileType smarty let b:surround_{char2nr('-')} = "{?* \r *?}"

autocmd FileType eruby let b:surround_{char2nr('=')} = "<%= \r %>"
autocmd FileType eruby let b:surround_{char2nr('-')} = "<% \r %>"

autocmd BufEnter */fixtures/*.rb ALEDisable

Plug 'mattn/emmet-vim'
Plug 'majutsushi/tagbar'

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


let g:tagbar_show_linenumbers = 1
let g:tagbar_autoshowtag = 1

" tagbar status update is too slow · Issue #413 · majutsushi/tagbar
" https://github.com/majutsushi/tagbar/issues/413
set updatetime=500


" lsp(LanguageClient-neovim)
"
"" Launch gopls when Go files are in use
"let g:LanguageClient_serverCommands = {
"       \ 'go': ['gopls']
"       \ }
"" Run gofmt on save
"autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
"

Plug 'w0rp/ale'

let g:ale_linters = {
\ 'python': ['flake8'],
\ 'javascript': ['prettier', 'flow']
\}

let g:ale_fixers = {
\   'ruby': ['rubocop'],
\   'python': ['autopep8','black','isort'],
\   'javascript': ['prettier']
\}
let g:ale_pattern_options = { 'schema.rb': { 'ale_enabled': 0 }}
let g:ale_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_set_quickfix = 1

let g:ale_ruby_rubocop_executable = expand('~/.rbenv/shims/rubocop')
"let g:ale_ruby_rubocop_executable = 'bundle'

" python
let g:ale_python_flake8_executable = expand('~/.pyenv/versions/neovim3/bin/flake8')
let g:ale_python_autopep8_executable = expand('~/.pyenv/versions/neovim3/bin/autopep8')
let g:ale_python_isort_executable = expand('~/.pyenv/versions/neovim3/bin/isort')
let g:ale_python_black_executable = expand('~/.pyenv/versions/neovim3/bin/black')


"let g:ale_javascript_prettier_eslint_excutable = expand('./node_modules/.bin/prettier-eslint')
"let g:ale_javascript_prettier_excutable = expand('./node_modules/.bin/prettier')
"let g:ale_javascript_eslint_excutable = expand('./node_modules/.bin/eslint')
"let g:ale_javascript_flow_excutable = expand('./node_modules/.bin/flow')

Plug 'junegunn/fzf.vim'
set rtp+=~/.fzf

nnoremap <Leader>c :Files<CR>
nnoremap <Leader>B :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>b :BTags<CR>

"Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'jgdavey/tslime.vim'
Plug 'ervandew/supertab'

Plug 'lighttiger2505/gtags.vim'

Plug 'MattesGroeger/vim-bookmarks'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

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
autocmd Filetype typescriptreact setlocal shiftwidth=2 tabstop=2

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
