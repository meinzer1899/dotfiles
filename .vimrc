set encoding=utf-8
set nocompatible
" Basti's VIMRC
"
map <Space> <Leader>
nnoremap <silent> \g :GitGutterToggle<CR>
nnoremap <silent> \p :ProseMode<CR>
nnoremap <silent> <Leader>m :FZFMru<CR>
nnoremap <silent> <Leader>s :update<CR>
nnoremap <silent> <Leader>gs :Git<CR>
nnoremap <silent> <Leader>cc :Commands<CR>

filetype off
inoremap jk <ESC>
inoremap jj <CR>
command! EVimrc :vs $MYVIMRC

" Open new split panes to right and buttom
set splitbelow
set splitright

set noshowmode " lightline shows the mode already
set laststatus=2 " to have colors within lightline status bar

set relativenumber
set number

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set signcolumn=yes " With this the left bar is broader for line numbers and linter symbols

set hidden      " Allow buffer switching even if unsaved
set wrap
set formatoptions-=tc " Dont let Vim split long lines to separate lines

" Fix Vim's ridiculous line wrapping model
set ww=<,>,[,],h,l

"Tabs and spacing
" show existing tab with 4 spaces width
" set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set autoindent
set cindent
set tabstop=4
set smarttab

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

" Autocommand
augroup vimrcEx
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or
    " when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" |
        \ endif
augroup END

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch' " Asynchronous build and test dispatcher 
Plug 'junegunn/goyo.vim' " Prose Mode
Plug 'altercation/vim-colors-solarized' " used by prose mode
Plug 'arcticicestudio/nord-vim' " next tops are: onedark and vim-moonfly-colors
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
" Plug 'dense-analysis/ale' " Asynchronous Linting Engine
" Plug 'maximbaz/lightline-ale'
Plug 'airblade/vim-gitgutter'
Plug 'pechorin/any-jump.vim'
Plug 'pbogut/fzf-mru.vim' " most recently used files
Plug 'junegunn/limelight.vim' " Hyperfocus writing in Vim
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets' " A bunch of useful language related snippets (ultisnips is the engine). :Snippets for all available snippets (depends on file type)
Plug 'mhinz/vim-startify'
Plug 'dyng/ctrlsf.vim'
Plug 'Pablo1107/codi.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'josa42/vim-lightline-coc'
Plug 'mbbill/undotree'
Plug 'stsewd/fzf-checkout.vim'
" Plug 'qpkorr/vim-bufkill'


" Initialize plugin system
call plug#end()

" post plugin section
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
"
" COLORS
"
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
syntax on
colorscheme onedark " moonfly (also adapt in lightline section)
if has("macunix") || has('win32')
    set clipboard=unnamed
elseif has("unix")
    set clipboard=unnamedplus
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg='ag --vimgrep'

  " Use ag in fzf for listing files. Lightning fast and respects .gitignore
  let $FZF_DEFAULT_COMMAND = 'ag --follow -H --literal --files-with-matches --nocolor -g ""'
endif

if executable('rg')
    let $FZF_DEFAULT_COMMAND='rg --files'
    set grepprg=rg\ --vimgrep
endif

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
" Always enable preview window on the right with 60% width (only if width of screen in larger than 120 columns)
let g:fzf_preview_window = 'right:60%'

" Rg command with preview window
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --follow --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
            \   fzf#vim#with_preview(), <bang>0)

" More advances ripgrep integration (see FZF@github)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --follow --column --line-number --no-heading --color=always --smart-case -- %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap <silent> <Leader>c  :Commits<CR>
nnoremap <silent> <Leader>bc :BCommits<CR>

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
nnoremap <silent> ; :Buffers<CR>
nnoremap <silent> <Leader>r :RG<CR>
nnoremap <silent> <Leader>t :Files<CR>
nnoremap <silent> <Leader>a :Ag<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>bl :BLines<CR>
nnoremap <silent> <Leader>gf :GFiles?<CR>
nnoremap <silent> <Leader>h :History<CR>

" makes j and k move by wrapped line unless I had a count, in which case it
" behaves normally
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" register compoments:
call lightline#coc#register()

" Lightline
let g:lightline = {
             \ 'colorscheme': 'onedark',
             \ 'active': {
             \   'left': [['mode', 'paste'], ['filename', 'modified']],
             \   'right': [['lineinfo'], ['percent'], ['readonly',
             \       'linter_warnings', 'linter_errors', 'linter_checking',
             \       'linter_infos']]
             \ },
             \ 'component_expand': {
             \   'linter_warnings': 'lightline#coc#warnings',
             \   'linter_errors': 'lightline#coc#errors',
             \   'linter_ok': 'lightline#coc#ok',
             \   'linter_checking': 'lightline#coc#status'
             \ },
             \ 'component_type': {
             \   'readonly': 'error',
             \   'linter_warnings': 'warning',
             \   'linter_errors': 'error',
             \   'linter_ok': 'left'
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
" let g:gitgutter_sign_added = '▌'
" let g:gitgutter_sign_modified = '▌'
" let g:gitgutter_sign_removed = '▌'
" let g:gitgutter_sign_modified_removed = '∙'
nnoremap <silent> ]g :GitGutterNextHunk<CR>
nnoremap <silent> [g :GitGutterPrevHunk<CR>
augroup VimDiff
    autocmd!
    autocmd VimEnter,FilterWritePre * if &diff | GitGutterDisable | endif
augroup END

" BUFFERS
" close the current buffer and move to the previous one
nnoremap <Leader>bq :<c-u>bp<bar>bd! #<cr>
" close all buffers except current one
nnoremap <Leader>bd :<c-u>up<bar>%bd<bar>e#<bar>bd#<cr>
" Disable rnumbers on inactive buffers for active screen indication
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set relativenumber
    autocmd WinLeave * set norelativenumber
augroup END

highlight StatusLineNC cterm=bold ctermfg=white ctermbg=darkgray

" CODI
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
let g:ctrlsf_search_mode = 'async'
nmap <Leader>n <Plug>CtrlSFCwordPath<CR>

" TERMINAL
if has('win32')
    noremap tn :tab term<CR>
else
    noremap tn :vert term<CR>source $HOME/.bash_profile<CR>clear<CR>
endif
" opens terminal vertically, executes make demo and closes after execution
nmap tt :vert term python3 %<CR>
" enter Terminal-Normal mode (for scrolling log output)
" https://stackoverflow.com/a/46822285/8981617
" Use CTRL W N to enter Terminal Normal Mode
" re-enter Terminal-Job mode by pressing i

" COC
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " Use <c-space> to trigger completion.
" if has('nvim')
"     inoremap <silent><expr> <c-space> coc#refresh()
" else
"     inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" ANY JUMP
" Normal mode: Jump to definition under cursore
nnoremap <leader>j :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>j :AnyJumpVisual<CR>
" Normal mode: open previous opened file (after jump)
nnoremap <leader>ab :AnyJumpBack<CR>
" Normal mode: open last closed search window again
nnoremap <leader>al :AnyJumpLastResults<CR>
" Show line numbers in search rusults
let g:any_jump_list_numbers = 1

" FZF CHECKOUT
let g:fzf_checkout_git_options = '--sort=-committerdate'
nnoremap <silent> <Leader>gc :GCheckout<CR>

" User Defined Commands (usr_40, 40.2)
command -nargs=? -bang Build :Dispatch<bang> -dir=build/ make -j$(nproc) <args>
command -nargs=0 -bang Test :Dispatch<bang> -dir=build/ make -j$(nproc) tests && GTEST_COLOR=1 ctest -V
command -nargs=? Prep :Dispatch! conan install . -g deploy --install-folder e3sdk_conandeploy --profile <args> && mkdir -p build && cd build && rm -rf ./* && conan install .. -p <args> && conan build -c .. && cd -
