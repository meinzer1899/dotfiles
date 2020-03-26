set encoding=utf-8
set nocompatible
" Basti's VIMRC
"
let mapleader = " "

filetype plugin indent on
inoremap jk <ESC>

" Plugin mangement
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/goyo.vim' " Prose Mode
Plug 'tomasr/molokai' " color scheme
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale' " Asynchronous Linting Engine
" Initialize plugin system
call plug#end()

"
" COLORS
"
syntax on
colorscheme molokai
set clipboard=unamedplus

" Open new split panes to right and buttom
set splitbelow
set splitright

set relativenumber
set number

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
" Aggregate swap files in one place
set directory^=$HOME/.vim/tmp//
" https://vi.stackexchange.com/a/179

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --nogroup --nocolor --column'

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>r :Tags<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>a :Rg!<CR>
nmap <Leader>c :Colors<CR>
