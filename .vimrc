let $RUBYHOME=$HOME."/.rbenv/versions/2.5.1"
set rubydll=$HOME/.rbenv/versions/2.5.1/lib/libruby.2.5.1.dylib


execute pathogen#infect()

if has("termguicolors")
  set termguicolors
endif

if (exists("$GOROOT"))
  set rtp+=$GOROOT/misc/vim
  set rtp+=$GOPATH/src/github.com/nsf/gocode/vim
endif

" ===================
" colors, appearance
" ===================

set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
syntax enable

" if $COLORFGBG is set, switch colorscheme based on the value
" vim defaults to dark unless it's set
if (exists("$COLORFGBG"))
  if  split($COLORFGBG, ";")[0] == 15
    "set background=dark
    colorscheme railscasts
  else
    "set background=light
    "colorscheme hemisu
    colorscheme github
  endif
else
  "colorscheme railscasts
  "colorscheme jellybeans
  colorscheme hybrid
endif

" solarized
"set background=dark
"let g:solarized_termtrans=1
"colorscheme solarized

set number
	
"set list
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

filetype plugin indent on

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2

" ===================
" key mapping
" ===================

let mapleader = ","

" this overrides jumps (CTRL-I # see :verbose map <C-i> )
nnoremap <Tab> gt
nnoremap <S-Tab> gT

nnoremap gl :Gitv!<cr>

nnoremap / /\v

nmap <Leader><C-w> :tabclose<cr>


" ===================
" mouse, clipboard
" ===================
 
" fixed using brew install reattach-to-usernamespace
" Fix Vim + Tmux yank/paste on unnamed register
" http://stackoverflow.com/questions/11404800/fix-vim-tmux-yank-paste-on-unnamed-register
"if $TMUX== ""
  if !has("nvim")
    set clipboard=unnamed,autoselect
  else
    "set clipboard=unnamed
    set clipboard+=unnamedplus

    let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
    let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
    "let g:python_host_prog = expand('~/.pyenv/shims/python')
    "let g:python3_host_prog = expand('~/.pyenv/shims/python3')
  endif
"endif

set mouse=a

" toggole paste/nopaste
noremap <Leader>v :set invpaste<CR>:set paste?<CR>

" toggle view for pase
noremap <Leader>p :set nonumber!<CR>:set nolist!<CR>

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
set fencs=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set fenc=utf-8

autocmd FileType gitcommit setlocal fenc=utf-8

set expandtab
set tabstop=2
set shiftwidth=2   " autoindent size
set backspace=2    " use delete key to go back to previous line

autocmd FileType make set noexpandtab

" ==================
" Window
" ==================

if bufwinnr(1)
  "nmap + <C-W>+
  "nmap - <C-W>-
  nmap < <C-W><
  nmap > <C-W>>
endif 

" ===================
" misc
" ===================

set noswapfile     " disable swap file creation

set visualbell     " disable beeping


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
        \ 'sort': 0,
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

" buftag ctag option
let g:ctrlp_buftag_types = {'php': '--language-force=php --php-types=cdfi'}

" ===================
" fzf
" ====================
set rtp+=~/.fzf
nnoremap <C-p> :FZFFileList<CR>
command! FZFFileList call fzf#run({
            \ 'source': 'find . -type d -name .git -prune -o ! -name .DS_Store',
            \ 'sink': 'e'})

" ===================
" NERDTree
" ===================

nnoremap <Leader>n :NERDTreeToggle<CR>

" pls don't hijack
let g:NERDTreeHijackNetrw = 0

" https://github.com/kien/ctrlp.vim/issues/78
let g:ctrlp_reuse_window = 'NERD_tree_2'

" sync nerdtree in everytab
" http://stackoverflow.com/questions/1979520/auto-open-nerdtree-in-every-tab
" autocmd VimEnter * NERDTree

function! MirrorNT()
endfunction

command! CallMirrorNT call MirrorNT()

autocmd BufEnter * CallMirrorNT

" show current file in finder
map <leader>r :NERDTreeFind<cr>

" ===================
" Align
" ===================
let g:Align_xstrlen=3

" ===================
" Gitv
" ===================

let g:Gitv_TruncateCommitSubjects = 1

" ///////////// Misc ////////////

" =====================
" local setting
" ====================

if filereadable(expand('~/dotfiles/local/.vimrc.local'))
    source ~/dotfiles/local/.vimrc.local
endif

" Project Specific .vimrc files
" https://andrew.stwrt.ca/posts/project-specific-vimrc/

set exrc
set secure

" ======================
" reload vimrc on change
" ======================

augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" expand current directory in command
" http://stackoverflow.com/questions/2170340/vim-e-starting-directory
cnoremap <Leader>e <c-r>=expand("%:h")<cr>

" ======================
" Smarty
" =====================

" http://stackoverflow.com/questions/5117991/vim-insert-empty-erb-tags
" <c-s>= to start(in terminal vim prefix with <c-g>s, yss= for existing
autocmd FileType smarty let b:surround_{char2nr('=')} = "{? \r ?}"
autocmd FileType smarty let b:surround_{char2nr('-')} = "{?* \r *?}"

" svn
command! -nargs=? SVNDiff :execute s:SVNDiff(<f-args>)
function! s:SVNDiff(...)
    let revision = ''
    if a:0 >= 1
        let revision = a:1
    endif
    let diffcmd = "%!svn cat " . revision . " " . expand("%:p")
    :vnew | exe diffcmd
    :diffthis
endfunction

" =====================
" Syntastic
" =====================

" Syntastic style

"    SyntasticErrorSign - For syntax errors, links to 'error' by default
"    SyntasticWarningSign - For syntax warnings, links to 'todo' by default
"    SyntasticStyleErrorSign - For style errors, links to 'SyntasticErrorSign'
"                              by default
"    SyntasticStyleWarningSign - For style warnings, links to
"                                'SyntasticWarningSign' by default
"
"Example: >
"    highlight SyntasticErrorSign guifg=white guibg=red

"highlight error guifg=red ctermfg=red
"highlight todo  guifg=yellow ctermfg=yellow

"let g:syntastic_ruby_rubocop_exec = expand('~/.rbenv/shims/rubocop')
"let g:syntastic_ruby_rubocop_exec = '/usr/local/Cellar/rbenv/HEAD/shims/ruby /usr/local/Cellar/rbenv/HEAD/shims/rubocop'
"/usr/local/Cellar/rbenv/HEAD/versions/2.1.5/bin/ruby
"let g:syntastic_ruby_rubocop_exec = '/usr/local/Cellar/rbenv/HEAD/versions/2.1.5/bin/ruby /usr/local/Cellar/rbenv/HEAD/versions/2.1.5/bin/rubocop'
"let g:syntastic_ruby_rubocop_exec = '/Users/okawa.rbenv/versions/2.2.1/bin/ruby /Users/okawa/.rbenv/versions/2.2.1/bin/rubocop'
let g:syntastic_ruby_rubocop_exec = expand('~/dotfiles/bin/rubocop-syntastic')
"let g:syntastic_rubocop_exec = '/usr/local/Cellar/rbenv/HEAD/versions/2.1.5/bin/ruby /usr/local/Cellar/rbenv/HEAD/versions/2.1.5/bin/rubocop'
let g:syntastic_mode_map = { 'mode' : 'passive', 'active_filetypes' : ['ruby','javascript','python'] }
let g:syntastic_ruby_checkers = ['rubocop']
"let g:syntastic_aggregate_errors = 0
"let g:syntastic_debug = 1
"let g:syntastic_debug_file = './syntastic.log'

let g:syntastic_aggregate_errors = 1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

let g:syntastic_python_checkers = ['pep8','flake8']
let g:syntastic_python_pep8_exec = expand('~/dotfiles/bin/pep8-syntastic')
let g:syntastic_python_flake8_exec = expand('~/.pyenv/versions/neovim3/bin/flake8')
let g:syntastic_python_flake8_args='--ignore=F821,E302,E501'

" =====================
" VCSCommand
" =====================
let mapleader = ','
 
nnoremap [VCS] <Nop>
nmap <Leader>v [VCS]
let g:VCSCommandMapPrefix = '[VCS]'

" =====================
" VCSCommand
" =====================

if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif

let g:vdebug_options.path_maps =  { "/home/vagrant/nfs_sync_dir/bm_php" : "/Users/takuokawa/Code/enigmo/buyma/jp/bm_dev_chef/nfs_sync_dir/php_apps" }

" =====================
" vim-rspec
" =====================

let g:rspec_command = 'call Send_to_Tmux("./bin/rspec {spec}\n")'
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" =====================
" File specific setting
" =====================

autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2

"set spell spelllang=en_us
