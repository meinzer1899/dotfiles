set encoding=utf-8
" nocompatible needed by vim-polyglot
set nocompatible
" meinzer1899's VIMRC
"
let mapleader = "\<Space>"
nnoremap <silent> \g :GitGutterToggle<CR>
nnoremap <silent> \p :ProseMode<CR>
nnoremap <silent> <Leader>m :FZFMru<CR>
nnoremap <silent> <Leader>s :update<CR>
nnoremap <silent> <Leader>gs :vertical :Git <CR>:vertical resize 45<CR>
nnoremap <silent> <Leader>gp :Git! push<CR>
nnoremap <silent> <Leader>cc :Commands<CR>
nnoremap <silent> <Leader>q :@:<CR>
nnoremap <silent> <Leader>co :Copen<CR> G<CR>
nnoremap <silent> <Leader>rc :vs $MYVIMRC<CR>

" mappings to make search results appear in the middle of the screen
" https://vim.fandom.com/wiki/Make_search_results_appear_in_the_middle_of_the_screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nnoremap g; g;zz
nnoremap g, g,zz

inoremap jj <CR>
" ci( does not jump automatically to parenthesis, fix with this two lines
nnoremap ci( f(ci(
nnoremap ci) f)ci)

" Open new split panes to right and buttom
set splitbelow

set noshowmode " lightline shows the mode already
set laststatus=2 " to have colors within lightline status bar

set relativenumber
set number

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu| (coc)
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" With this the left bar is broader for line numbers and linter symbols
set signcolumn=yes

" Allow buffer switching even if unsaved
set hidden
set wrap
" help fo-table.  set fo=croq (only format comments, good for code), set fo=tcrq for text
set fo=croq

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
set colorcolumn=+1
au BufRead,BufNewFile *.md setlocal textwidth=80
" Searching
" case insensitive
set ignorecase
" use case if any caps used
set smartcase
" show match as search proceeds
set incsearch

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" diffopt
set diffopt=filler,context:3,iwhite,hiddenoff
if has('nvim-0.3.2') || has("patch-8.1.0360")
    " https://old.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim/
    set diffopt+=internal,algorithm:histogram,indent-heuristic
endif

" https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character
set selection=exclusive

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

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
    autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=sh
    autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
    autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
    autocmd BufRead,BufNewFile vimrc.local set filetype=vim
    autocmd BufRead,BufNewFile .vimrc set filetype=vim
    autocmd BufRead,BufNewFile CMakeLists.txt set filetype=cmake
    autocmd BufRead,BufNewFile *.tpp set filetype=cpp
augroup END

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
" Asynchronous build and test dispatcher
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
 " Prose Mode
" Plug 'junegunn/goyo.vim'
" used by prose mode
" Plug 'altercation/vim-colors-solarized'
 " also nice: EdenEast/nightfox
Plug 'joshdick/onedark.vim'
let g:onedark_terminal_italics=1
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'pechorin/any-jump.vim'
" most recently used files
Plug 'pbogut/fzf-mru.vim'
" Hyperfocus writing in Vim
Plug 'junegunn/limelight.vim'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
Plug 'dyng/ctrlsf.vim'
" Plug 'metakirby5/codi.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-explorer coc-json coc-docker coc-diagnostic coc-snippets coc-yank coc-jedi coc-rust-analyzer'}
Plug 'sheerun/vim-polyglot'
Plug 'josa42/vim-lightline-coc'
Plug 'mbbill/undotree'
Plug 'stsewd/fzf-checkout.vim'
" Plug 'goerz/jupytext.vim'
" Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'jpalardy/vim-slime'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/gv.vim'
" Plug 'dbeniamine/cheat.sh-vim'
Plug 'unblevable/quick-scope'
Plug 'ilyachur/cmake4vim'
Plug 'muellan/vim-brace-for-umlauts'
" Plug 'cohama/lexima.vim'
Plug 'Yggdroot/indentLine'
Plug 'Asheq/close-buffers.vim'
Plug 'antoinemadec/coc-fzf'
Plug 'chaoren/vim-wordmotion'
Plug 'rust-lang/rust.vim'
Plug 'jesseleite/vim-agriculture'
Plug 'romainl/vim-qf'
Plug 'junegunn/vim-peekaboo'
Plug 'luochen1990/rainbow'
"set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
" Intelligently reopen files at your last edit position
Plug 'farmergreg/vim-lastplace'
" let g:lastplace_ignore_buftype = "quickfix"
" Easy text exchange operator for Vim
Plug 'tommcdo/vim-exchange'
" add buffers to tabline
Plug 'mengelbrecht/lightline-bufferline'
" always show tabline
set showtabline=2
Plug 'KabbAmine/zeavim.vim'
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'plantuml', 'vim-plug']}
" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown', 'plantuml']
" Plug 'justinmk/vim-sneak'

" Initialize plugin system
call plug#end()

" post plugin section
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
"
" COLORS
"
if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
    set termguicolors
endif

syntax on
colorscheme onedark " also adapt in lightline section
if has("macunix") || has('win32')
    set clipboard=unnamed
elseif has("unix")
    set clipboard=unnamedplus
endif

" FZF
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ackprg='ag --vimgrep'

    " Use ag in fzf for listing files. Lightning fast and respects .gitignore
    let $FZF_DEFAULT_COMMAND='ag --follow -H --literal --files-with-matches --nocolor -g ""'
endif

if executable('rg')
    let $FZF_DEFAULT_COMMAND='rg --files --follow --hidden --no-ignore-dot'
    set grepprg=rg\ --vimgrep
endif

if executable('fd')
    let $FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
endif

let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always
            \ --format="%C(yellow)%h%C(red)%d%C(reset)
            \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
" Preview window is shownn by default. You can toggle it with ctrl-/.
" It will show on the right with 50% width, but if the width is smaller
" than 70 columns, it will show above the candidate list
let g:fzf_preview_window = ['right,50%,<70(up,40%)', 'ctrl-/']


" See `man fzf-tmux` for available options
if exists('$TMUX')
    let g:fzf_layout = { 'tmux': '-p90%,60%' } 
    " let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'top' } }
else
    " Adapt fzf preview window layout (non-floating, dont push content of current
    " screen to the top (https://github.com/junegunn/fzf.vim/issues/942)
    let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'top' } }
endif

" An action can be a reference to a function that processes selected lines
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Call Ag and Rg to only match file content, not file names
" added: trim whitespaces when displaying results
" https://github.com/junegunn/fzf.vim/issues/714#issuecomment-428802659
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --trim  ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

" A lot faster, but without fuzzy find
" from: https://github.com/junegunn/fzf.vim#example-advanced-ripgrep-integration
" added: trim whitespaces when displaying results
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --trim -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--disabled', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  let spec = fzf#vim#with_preview(spec, 'right', 'ctrl-/')
  call fzf#vim#grep(initial_command, 1, spec, a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
nnoremap <silent> <Leader>,     :Buffers<CR>
nnoremap <silent> <Leader>rr    :Rg<CR>
nnoremap <silent> <Leader>aa    :RG<CR>
" nnoremap <silent> <Leader>aa    :Ag<CR>
nnoremap <silent> <Leader>t     :Files<CR>
nnoremap <silent> <Leader>l     :Lines<CR>
nnoremap <silent> <Leader>bl    :BLines<CR>
nnoremap <silent> <Leader>gf    :GFiles?<CR>
nnoremap <silent> <Leader>h     :History:<CR>
nnoremap <silent> <Leader>c     :Commits<CR>
nnoremap <silent> <Leader>bc    :BCommits<CR>

" merge conflict commands in a 3-way-diff (1: middle, 2: left, 3: right side)
nnoremap <Leader>gj :diffget //3<CR>
nnoremap <Leader>gf :diffget //2<CR>

" makes j and k move by wrapped line unless I had a count, in which case it
" behaves normally
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" LIGHTLINE
" register compoments:
call lightline#coc#register()

" Lightline bufferline
" update modified indicator immediately
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

" switch to buffers using their ordinal number in the bufferline
let g:lightline#bufferline#show_number  = 2
nnoremap <Leader>1 <Plug>lightline#bufferline#go(1)
nnoremap <Leader>2 <Plug>lightline#bufferline#go(2)
nnoremap <Leader>3 <Plug>lightline#bufferline#go(3)
nnoremap <Leader>4 <Plug>lightline#bufferline#go(4)
nnoremap <Leader>5 <Plug>lightline#bufferline#go(5)
nnoremap <Leader>6 <Plug>lightline#bufferline#go(6)
nnoremap <Leader>7 <Plug>lightline#bufferline#go(7)
nnoremap <Leader>8 <Plug>lightline#bufferline#go(8)
nnoremap <Leader>9 <Plug>lightline#bufferline#go(9)
nnoremap <Leader>0 <Plug>lightline#bufferline#go(10)

let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ }

let g:lightline.active = {
            \ 'left': [['mode', 'paste'], ['readonly', 'filename', 'fileformat', 'modified']],
            \ 'right': [['lineinfo'], ['percent'], ['readonly',
            \       'linter_warnings', 'linter_errors', 'linter_checking',
            \       'linter_infos']]
            \ }

let g:lightline.tabline = {
            \   'left': [ ['buffers'] ],
            \   'right': [ ['gitbranch'] ]
            \ }

let g:lightline.component_expand = {
            \   'buffers': 'lightline#bufferline#buffers',
            \   'linter_warnings': 'lightline#coc#warnings',
            \   'linter_errors': 'lightline#coc#errors',
            \   'linter_ok': 'lightline#coc#ok',
            \   'linter_checking': 'lightline#coc#status'
            \ }

let g:lightline.component_type = {
            \   'buffers': 'tabsel',
            \   'readonly': 'error',
            \   'linter_warnings': 'warning',
            \   'linter_errors': 'error',
            \   'linter_info': 'info',
            \   'linter_hints': 'hints',
            \   'linter_ok': 'left',
            \ }

let g:lightline.component_function = {
            \ 'fileformat': 'LightlineFileformat',
            \ 'gitbranch': 'FugitiveHead'
            \ }

" shrink file name when window size falls below threshold
function! LightlineFileformat()
  if &filetype !=? 'NvimTree' && &filetype !=? 'tagbar' &&
  \  &filetype !=? 'taglist' && &filetype !=? 'vista'
    return winwidth(0) > 70 ?
         \ (tolower(&fileformat)) :
         \ ''
  else
    return ''
  endif
endfunction

" bufferline
let g:lightline#bufferline#enable_devicons = 1

" Prose Mode for distraction free writing
function! ProseMode()
    call goyo#execute(0, [])
    set spell noci nosi noai nolist noshowmode noshowcmd
    set complete+=s
    colors solarized
    set bg=light
endfunction
command! ProseMode call ProseMode()

nnoremap <silent> ]g :GitGutterNextHunk<CR>
nnoremap <silent> [g :GitGutterPrevHunk<CR>
augroup VimDiff
    autocmd!
    autocmd VimEnter,FilterWritePre * if &diff | GitGutterDisable | endif
augroup END

" BUFFERS
" bdelete all buffers except the buffer in the current window
nnoremap <Leader>bdo :Bdelete other<CR>
" bdelete buffers not visible in a window
nnoremap <Leader>bdh :Bdelete hidden<CR>
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
let g:ctrlsf_winsize = '40%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_focus = {
    \ 'at': 'start',
    \ }
let g:ctrlsf_search_mode = 'async'
nnoremap <Leader>n <Plug>CtrlSFCwordPath -hidden<CR>
vmap     <leader>N <Plug>CtrlSFVwordPath

" TERMINAL
if has('win32')
    noremap <Leader>p :tab term<CR>
else
    noremap <silent><Leader>p :term ++rows=12<CR>source $HOME/.bash_profile<CR>clear<CR>
endif
" enter Terminal-Normal mode (for scrolling log output)
" https://stackoverflow.com/a/46822285/8981617
" Use CTRL W N to enter Terminal Normal Mode
" re-enter Terminal-Job mode by pressing i

" COC
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" " coc-snippets
" " Use tab for trigger completion with characters ahead and navigate.
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ CheckBackspace() ? "\<TAB>" :
"       \ coc#refresh()

" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-n>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-p>'

" Change navigation of completion info popup
inoremap <expr> <C-j> coc#pum#visible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> coc#pum#visible() ? "\<C-p>" : "\<C-k>"

" flaot & scroll
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait> <C-w>f <Plug>(coc-float-jump)
  nnoremap <silent><nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
  nnoremap <silent><nowait><expr> <C-p> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-p>"
  inoremap <silent><nowait><expr> <C-n> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-p> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-n> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-n>"
  vnoremap <silent><nowait><expr> <C-p> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-p>"
endif

" Setup prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> gI <Plug>(coc-diagnostic-info)

" GoTo code navigation.
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gt <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming and refactoring
nnoremap <leader>rn <Plug>(coc-rename)
nnoremap <Leader>rf <Plug>(coc-refactor)

" ccls specific c++
" call hierarchy
nnoremap <silent> gl :call CocLocations('ccls','$ccls/call', {'hierarchy':v:true,'levels':5})<CR>
nnoremap <silent> gL :call CocLocations('ccls','$ccls/call',{'callee':v:true,'levels':5})<cr>
" outline
nnoremap <silent> go :CocFzfList outline<CR>
" Search workspace symbols
nnoremap <silent> gs  :<C-u>CocList -I symbols<cr>

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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
nnoremap <silent> <Leader>gc :GBranches<CR>

" Coc Explorer
nnoremap <silent> <Leader>o :CocCommand explorer --sources=file+ --width=50<CR>
nmap <Leader>er <Cmd>call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>

" vim-slime
" spawns REPL environment
let g:slime_target = "vimterminal"
let g:slime_vimterminal_cmd = "python"
" Send whole file to slime via C-c C-x
nnoremap <c-c><c-x> :%SlimeSend<cr>

" coc-yank
" show list with yanked lines
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" vim-quickscope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim indentLine
let g:indentLine_char = '▏'
let g:indentLine_setColors = 0 "0: highlight conceal color with your colorscheme

" coc-fzf
let g:coc_fzf_preview = 'right:40%'

" vim-agriculture
vnoremap <Leader>rr <Plug>RgRawVisualSelection<cr>
vnoremap <Leader>aa <Plug>AgRawVisualSelection<cr>

" rainbow parenthesis
" rainbow breakes cmake syntax highlighting
" https://github.com/luochen1990/rainbow/issues/77
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\}

" persistent undo
" from https://bluz71.github.io/2021/09/10/vim-tips-revisited.html
let s:undodir = "/tmp/.undodir_" . $USER
if !isdirectory(s:undodir)
    call mkdir(s:undodir, "", 0700)
endif
let &undodir=s:undodir
set undofile

" cmake4vim
let g:cmake_build_dir = 'build'
let g:cmake_compile_commands = 1
let g:cmake_build_executor = 'dispatch'

" User Defined Commands (usr_40, 40.2)
command -nargs=? -bang Build :Dispatch<bang> -dir=/mnt/build/ make -j$(nproc) <args>
command -nargs=0 -bang Test :Dispatch<bang> -dir=/mnt/build/ make -j$(nproc) tests && GTEST_COLOR=1 ctest -V
command -nargs=0 -bang BuildDoc :Dispatch<bang> -dir=/mnt/build/ make -j$(nproc) doc && grep -v suvcommon doc/doxygen/html/doxygen_warnings.log
command -nargs=? Prep :Dispatch! rm -rf e3sdk_conandeploy || return && conan install . -g deploy --install-folder e3sdk_conandeploy --profile <args> && mkdir -p build && cd build || exit && rm -rf ./* || return && conan install .. --profile <args> && conan build -c .. && cd -
command -nargs=0 -bang Cover :Dispatch<bang> -dir=/mnt/build/ cmake -DCMAKE_CXX_FLAGS="-fprofile-arcs -ftest-coverage -g -O0" .. && make tests -j$(nproc) && ctest && /home/e3-user/.local/bin/gcovr --exclude-unreachable-branches --exclude-throw-branches -r .. -e ../src/gen -e ../tests -e ../submodules/e3_subm_dhm_arxml/generated --html-details coverage.html
