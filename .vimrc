
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

" ===================
" gui options
" ===================

set guioptions-=T  " hide toolbar
set showtabline=2  " always show tablines
set guifont=Monaco:h13


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

nnoremap <Leader>b :CtrlPBufTag<CR> 
nnoremap <Leader>B :CtrlPBuffer<CR> 
nnoremap <Leader>t :CtrlPTag<CR> 

" buftag ctag option
let g:ctrlp_buftag_types = {'php': '--language-force=php --php-types=cdfi'}

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
