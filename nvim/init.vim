"set shell=$HOME/dotfiles/nvim/wrapper.sh

let mapleader = ","

set noswapfile

set expandtab
set tabstop=2

" Script
let g:ruby_host_prog = expand('~/.anyenv/envs/rbenv/shims/neovim-ruby-host')
let g:python_host_prog = expand('~/anyenv/envs/pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/neovim3/bin/python')
let g:node_host_prog = expand('~/.anyenv/envs/nodenv/versions/16.13.1/bin/neovim-node-host')


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
"Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'othree/yajs.vim'
Plug 'slim-template/vim-slim'
Plug 'hashivim/vim-terraform'
Plug 'ayu-theme/ayu-vim'
Plug 'shumphrey/fugitive-gitlab.vim'
let g:fugitive_gitlab_domains = ['https://gitlab.enigmo.co.jp']
Plug 'elmcast/elm-vim'
Plug 'evanleck/vim-svelte'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'tag': '*' }
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }


" https://github.com/neoclide/coc.nvim
" TODO: CocInstall coc-json coc-tsserver or CocConfig
Plug 'neoclide/coc.nvim', {'branch': 'release'}
source $HOME/dotfiles/nvim/coc-settings.vim

" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" 
" Plug 'prabirshrestha/vim-lsp'
" " TODO: https://github.com/neovim/nvim-lspconfig
" " or https://eitoball.hatenablog.com/entry/2019/12/02/033349
" Plug 'mattn/vim-lsp-settings'
" 
" if executable('solargraph')
"     " gem install solargraph
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'solargraph',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
"         \ 'initialization_options': {"diagnostics": "true"},
"         \ 'whitelist': ['ruby'],
"         \ })
" endif

" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ asyncomplete#force_refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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

"let g:ale_ruby_rubocop_executable = expand('~/.rbenv/shims/rubocop')
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

set rtp+=~/.fzf
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }

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
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate'}

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
Plug 'joshdick/onedark.vim'
Plug 't4ku/onehalf', { 'rtp': 'vim/', 'branch': 'personal_fixes' }
Plug 'jacoborus/tender.vim'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts=1

Plug 'ryanoasis/vim-devicons'

Plug 'janko/vim-test'
"Plug 'janko/tslime.vim'

" https://github.com/vim-test/vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "tslime"

let g:test#preserve_screen = 1
let g:test#echo_command = 0

let g:test#ruby#rspec#executable = 'docker-compose exec spring bin/rspec'
" unlet g:test#ruby#rspec#executable 

" https://github.com/jgdavey/tslime.vim
let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1

call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {
      'toml',
      'c_sharp',
      'vue',
    }
  }
}
EOF

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

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
"if (empty($TMUX))
"  if (has("nvim"))
"    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"  endif
"  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
"  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
"  if (has("termguicolors"))
"    set termguicolors
"  endif
"endif

if (exists("$COLORFGBG"))
  if  split($COLORFGBG, ";")[0] == 15
    colorscheme onehalfdark
    set background=dark
    "colorscheme railscasts
  else
    colorscheme onehalflight
    set background=light
    "colorscheme hemisu
    "colorscheme github
  endif
else
  "colorscheme railscasts
  "colorscheme jellybeans
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


" generating fzf color from fzf-vim
" https://github.com/junegunn/fzf/blob/master/ADVANCED.md#color-themes
" let g:fzf_colors =
" \ { 'fg':         ['fg', 'Normal'],
"   \ 'bg':         ['bg', 'Normal'],
"   \ 'preview-bg': ['bg', 'Normal'],
"   \ 'hl':         ['fg', 'Comment'],
"   \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':        ['fg', 'Statement'],
"   \ 'info':       ['fg', 'PreProc'],
"   \ 'border':     ['fg', 'Ignore'],
"   \ 'prompt':     ['fg', 'Conditional'],
"   \ 'pointer':    ['fg', 'Exception'],
"   \ 'marker':     ['fg', 'Keyword'],
"   \ 'spinner':    ['fg', 'Label'],
"   \ 'header':     ['fg', 'Comment'] }
