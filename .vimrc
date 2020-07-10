set encoding=utf-8
set nocompatible
" Basti's VIMRC
"
let mapleader = " "
nnoremap <silent> \g :GitGutterToggle<CR>
nnoremap <silent> \p :ProseMode<CR>
nnoremap <silent> <Leader>m :FZFMru<CR>
nnoremap <silent> <Leader>s :update<CR>
nnoremap <silent> <Leader>gs :Git<CR>
nnoremap <silent> <Leader>cc :Commands<CR>

filetype off
inoremap jk <ESC>
inoremap jj <CR>
command! Vimrc :vs $MYVIMRC

" Open new split panes to right and buttom
set splitbelow
set splitright

set noshowmode " lightline shows the mode already
set laststatus=2 " to have colors within lightline status bar

set relativenumber
set number

set hidden      " Allow buffer switching even if unsaved
set wrap
set formatoptions-=tc " Dont let Vim split long lines to separate lines

" Fix Vim's ridiculous line wrapping model
set ww=<,>,[,],h,l

" show existing tab with 4 spaces width
" set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" --- backup and swap files ---
"  " I save all the time, those are annoying and unnecessary...
set nobackup
set nowritebackup
set noswapfile

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1
" Searching
set ignorecase " case insensitive
set smartcase  " use case if any caps used
set incsearch  " show match as search proceeds

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
Plug 'altercation/vim-colors-solarized' " used by prose mode
" Plug 'bluz71/vim-moonfly-colors'
Plug 'itchyny/lightline.vim'
Plug 'dense-analysis/ale' " Asynchronous Linting Engine
Plug 'maximbaz/lightline-ale'
Plug 'airblade/vim-gitgutter'
" Plug 'pechorin/any-jump.vim'
Plug 'pbogut/fzf-mru.vim' " most recently used files
Plug 'junegunn/limelight.vim' " Hyperfocus writing in Vim
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " A bunch of useful language related snippets (ultisnips is the engine). :Snippets for all available snippets (depends on file type)
Plug 'arcticicestudio/nord-vim' " next tops are: vim-janah and vim-moonfly-colors
Plug 'mhinz/vim-startify'
Plug 'dyng/ctrlsf.vim'
Plug 'Pablo1107/codi.vim'

" Initialize plugin system
call plug#end()

"
" COLORS
"
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
syntax on
colorscheme nord " moonfly (also adapt in lightline section)
if has("macunix") || has('win32')
    set clipboard=unnamed
elseif has("unix")
    set clipboard=unnamedplus
endif


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  let g:ackprg = 'ag --vimgrep'

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --all-types --literal --files-with-matches --nocolor
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
nnoremap <silent> <Leader>bl :BLines<CR>
nnoremap <silent> <Leader>g :GFiles?<CR>
nnoremap <silent> <Leader>h :History<CR>

" makes j and k move by wrapped line unless I had a count, in which case it
" behaves normally
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

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

" shellcheck
call ale#linter#Define('sh', {
            \   'name': 'shell',
            \   'output_stream': 'stderr',
            \   'executable': function('ale_linters#sh#shell#GetExecutable'),
            \   'command': function('ale_linters#sh#shell#GetCommand'),
            \   'callback': 'ale_linters#sh#shell#Handle',
            \})


" Lightline
let g:lightline = {
            \ 'colorscheme': 'nord',
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

" BUFFERS
" close the current buffer and move to the previous one
nnoremap <leader>bq :<c-u>bp<bar>bd! #<cr>
" close all buffers except current one
nnoremap <leader>bd :<c-u>up<bar>%bd<bar>e#<cr>

" Disable rnumbers on inactive buffers for active screen indication
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set relativenumber
    autocmd WinLeave * set norelativenumber
augroup END

highlight StatusLineNC cterm=bold ctermfg=white ctermbg=darkgray

let g:codi#interpreters = {
    \ 'python': {
    \ 'bin': 'python',
    \ 'prompt': '^\(>>>\|\.\.\.\) ',
    \ },
    \ }

" CtrlSF
let g:ctrlsf_winsize = '33%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }
nmap     <Leader>n <Plug>CtrlSFCwordPath<CR>
" let g:ctrlsf_search_mode = 'async'

" TERMINAL
if has('win32')
    nmap <leader>t :tab term<CR>
else
    nmap <leader>t :vert term<CR>source $HOME/.bash_profile<CR>clear<CR>
endif

" opens terminal vertically, executes make demo and closes after execution
nmap tt :vert term ++close make demo<CR>

" Reload file on focus/enter. This seems to break in Windows.
" https://stackoverflow.com/a/20418591
if !has("win32")
    au FocusGained,BufEnter * :silent! !
endif
