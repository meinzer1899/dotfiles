set encoding=utf-8
set nocompatible
" Basti's VIMRC
"
let mapleader = " "
nnoremap <silent> \g :GitGutterToggle<CR>
nnoremap <silent> \p :ProseMode<CR>
nnoremap <silent> <Leader>m :FZFMru<CR>

filetype plugin indent on
inoremap jk <ESC>
:command! BW :bn|:bd# " close buffer w/o closing window

" Plugin mangement
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim' " Prose Mode
Plug 'tomasr/molokai' " color scheme
Plug 'altercation/vim-colors-solarized' " used by prose mode
Plug 'bluz71/vim-moonfly-colors'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale' " Asynchronous Linting Engine
Plug 'maximbaz/lightline-ale'
Plug 'airblade/vim-gitgutter'
Plug 'pbogut/fzf-mru.vim' " most recently used files
" Initialize plugin system
call plug#end()

"
" COLORS
"
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
syntax on
colorscheme moonfly
set clipboard=unamedplus

" Open new split panes to right and buttom
set splitbelow
set splitright

set noshowmode " lightline shows the mode already
set laststatus=2 " to have colors within lightline status bar

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
  let g:ackprg = 'ag --vimgrep'

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor
              \ --hidden -g ""'
endif

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

nnoremap <silent> <Leader>c  :Commits<CR>
nnoremap <silent> <Leader>bc :BCommits<CR>

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
nnoremap <silent> ; :Buffers<CR>
nnoremap <silent> <Leader>r :Tags<CR>
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>a :Ag<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>g :GFiles?<CR>
nnoremap <silent> <Leader>h :History<CR>

" ALE
let g:lightline#ale#indicator_warnings = '▲'
let g:lightline#ale#indicator_errors = '✗'
highlight link ALEWarningSign String
highlight link ALEErrorSign Title
nnoremap <silent> ]w :ALENextWrap<CR>
nnoremap <silent> [w :ALEPreviousWrap<CR>
nnoremap <silent> <Leader>f <Plug>(ale_fix)
augroup VimDiff
    autocmd!
    autocmd VimEnter,FilterWritePre * if &diff | ALEDisable | endif
augroup END

" Lightline
let g:lightline = {
            \ 'colorscheme': 'moonfly',
            \ 'active': {
            \   'left': [['mode', 'paste'], ['filename', 'modified']],
            \   'right': [['lineinfo'], ['percent'], ['readonly',
            \       'linter_warnings', 'linter_errors', 'linter_checking',
            \       'linter_infos']]
            \ },
            \ 'component_expand': {
            \   'linter_warnings': 'lightline#ale#warnings',
            \   'linter_errors': 'lightline#ale#errors',
            \   'linter_ok': 'lightline#ale#ok',
            \   'linter_checking': 'lightline#ale#checking',
            \   'linter_infos': 'lightline#ale#infos'
            \ },
            \ 'component_type': {
            \   'readonly': 'error',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \   'linter_infos': 'right',
            \   'linter_checking': 'right'
            \ },
            \ }

" Prose Mode for distraction free writing
" FIXME: does not switch to solarized light theme
function! ProseMode()
    call goyo#execute(0, [])
    set spell noci nosi noai nolist noshowmode noshowcmd
    set complete+=s
    colors solarized
    set bg=light
endfunction
command! ProseMode call ProseMode()

" git gutter stylin
let g:gitgutter_sign_added = '▌'
let g:gitgutter_sign_modified = '▌'
let g:gitgutter_sign_removed = '▌'
let g:gitgutter_sign_modified_removed = '∙'
nnoremap <silent> ]g :GitGutterNextHunk<CR>
nnoremap <silent> [g :GitGutterPrevHunk<CR>
augroup VimDiff
    autocmd!
    autocmd VimEnter,FilterWritePre * if &diff | GitGutterDisable | endif
augroup END
