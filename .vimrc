" meinzer1899's VIMRC

" Vim guides
" https://google.github.io/styleguide/vimscriptguide.xml
" https://rbtnn.hateblo.jp/entry/2014/12/28/010913
" https://github.com/skwp/dotfiles/blob/master/vimrc

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set encoding=utf-8
scriptencoding utf-8

" Open new split panes to right and buttom
set splitbelow

" lightline shows the mode already
set noshowmode
" to have colors within lightline status bar
set laststatus=2

set relativenumber
" Line numbers are good
set number

" No sounds
set visualbell
" Reload files changed outside vim
set autoread

" Show current mode down the bottom
set showmode

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=150
set lazyredraw

" Don't pass messages to |ins-completion-menu| (coc)
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Allow buffer switching even if unsaved
set hidden
set wrap
" help fo-table.  set fo=croq (only format comments, good for code), set fo=tcrq for text
set fo=croq

" Fix Vim's ridiculous line wrapping model
set whichwrap=<,>,[,],h,l
" set nowrap       "Don't wrap lines
"Wrap lines at convenient points
set linebreak

" ================ Folds ============================

"fold based on indent
set foldmethod=indent
"deepest fold is 3 levels
set foldnestmax=3
"dont fold by default
set nofoldenable

"" ================ Indentation ======================
"
" show existing tab with 4 spaces width
" set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set autoindent
set tabstop=4
set smarttab
set smartindent

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" post plugin section
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" --- backup and swap files ---
" I save all the time, those are annoying and unnecessary...
set nobackup
set nowritebackup
set noswapfile

" Make it obvious where 80 characters is
set colorcolumn=+1

" Searching
" case insensitive...
set ignorecase
" unlesse any caps are used
set smartcase
" show match as search proceeds
set incsearch
" Highlight searches by default
set hlsearch
" and unhighlight when pressing C-c
nnoremap <nowait><silent> <C-C> :noh<CR>

" ================ Security ==========================
set modelines=0
set nomodeline

" turn on syntax highlighting
syntax on

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*vim/backups*
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*/.git/*,*/.svn/*,*.DS_Store
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*

" ================ Scrolling ========================

"Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

let g:mapleader = ' '
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

" enable a simple form of dot repetition over visual line selections
xnoremap . :norm.<CR>
" clones paragraph and pastes it below copied from paragraph
nnoremap cp yap<S-}>p
" Control-v is a common system level shortcut to paste from the clipboard. So why not use it also to paste from the system clipboard when in insert mode.
inoremap <C-v> <C-r>+
" Automatically equalize splits when Vim is resized (e.g. because of tmux split)
autocmd VimResized * wincmd =

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

" diffopt
set diffopt=filler,context:3,iwhite,hiddenoff
if has('nvim-0.3.2') || has('patch-8.1.0360')
    " https://old.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim/
    set diffopt+=internal,algorithm:histogram,indent-heuristic
endif

" https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character
set selection=exclusive

" Don't render (auto-format) markdown syntax
set conceallevel=0

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
    autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
    autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
    autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=zsh
    autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
    autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
    autocmd BufRead,BufNewFile vimrc.local set filetype=vim
    autocmd BufRead,BufNewFile .vimrc set filetype=vim
    autocmd BufRead,BufNewFile CMakeLists.txt set filetype=cmake
    autocmd BufRead,BufNewFile *.tpp set filetype=cpp
    autocmd BufRead,BufNewFile .clang-format set filetype=yaml
    autocmd FileType {markdown,gitcommit} setlocal spell spelllang=en_us
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    " Highlight the symbol and its references
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'mileszs/ack.vim'
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
Plug 'junegunn/goyo.vim'
" used by prose mode
" Plug 'altercation/vim-colors-solarized'
 " also nice: EdenEast/nightfox
Plug 'joshdick/onedark.vim'
let g:onedark_terminal_italics=1
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'Everblush/everblush.vim'
let g:everblush_transp_bg = 1
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
let g:gitgutter_set_sign_backgrounds = 1
" Plug 'pechorin/any-jump.vim'
" most recently used files
" Plug 'pbogut/fzf-mru.vim'
" Hyperfocus writing in Vim
" Plug 'junegunn/limelight.vim'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify'
Plug 'dyng/ctrlsf.vim'
" Plug 'metakirby5/codi.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'josa42/vim-lightline-coc'
Plug 'mbbill/undotree'
Plug 'stsewd/fzf-checkout.vim'
" Plug 'goerz/jupytext.vim'
" Plug 'jackguo380/vim-lsp-cxx-highlight'
" or (newer)
" Plug 'bfrg/vim-cpp-modern'
" REPL environment
" Plug 'jpalardy/vim-slime'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/gv.vim'
" Plug 'dbeniamine/cheat.sh-vim'
" Plug 'unblevable/quick-scope'
Plug 'ilyachur/cmake4vim'
Plug 'muellan/vim-brace-for-umlauts'
" Plug 'cohama/lexima.vim'
Plug 'Yggdroot/indentLine'
Plug 'Asheq/close-buffers.vim'
Plug 'antoinemadec/coc-fzf'
" Plug 'chaoren/vim-wordmotion'
Plug 'rust-lang/rust.vim'
Plug 'jesseleite/vim-agriculture'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'romainl/vim-qf'
" let g:qf_bufname_or_text = 2 " filter only on quickfix text, not bufnames
Plug 'junegunn/vim-peekaboo'
Plug 'luochen1990/rainbow'
"set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1
" Intelligently reopen files at your last edit position
Plug 'farmergreg/vim-lastplace'
" let g:lastplace_ignore_buftype = 'quickfix'
" Easy text exchange operator for Vim
" Plug 'tommcdo/vim-exchange'
" add buffers to tabline
Plug 'mengelbrecht/lightline-bufferline'
" always show tabline
set showtabline=2
" Plug 'KabbAmine/zeavim.vim'
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown', 'plantuml']
Plug 'justinmk/vim-sneak'
Plug 'kana/vim-niceblock'
Plug 'z-shell/zi-vim-syntax'

" Initialize plugin system
call plug#end()
"
" COLORS
"
if (has('nvim'))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has('termguicolors'))
    set termguicolors
endif

" also adapt in lightline section
" colorscheme catppuccin_frappe
" colorscheme everblush
colorscheme onedark
if has('macunix') || has('win32')
    set clipboard=unnamed
elseif has('unix')
    set clipboard=unnamedplus
endif

" FZF
if executable('rg')
    " use the same as in.zshrc
    " let $FZF_DEFAULT_COMMAND='rg --files --follow --hidden --no-ignore-dot'
    " https://github.com/BurntSushi/ripgrep/issues/425
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat+=%f:%l:%c:%m
    inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
endif

if executable('fd')
    " use the same as in.zshrc
    " let $FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    " https://github.com/junegunn/fzf.vim#completion-functions
    " path completion with fd in insert mode
    " inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
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

" add own flags to command from fzf.vim
" https://github.com/junegunn/fzf.vim/blob/master/plugin/fzf.vim
" keep searching for filenames as well: so its possible to select matches in
" differentt file types (e.g. .cpp)
" TODO: use string variable for flags
" TODO: use bind to toggle --no-ignore
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --trim --no-ignore --hidden --glob '!*.git' -- ".shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=* RG call fzf#vim#grep2("rg --column --line-number --no-heading --color=always --smart-case --trim --no-ignore --hidden --glob '!*.git' -- ", <q-args>, fzf#vim#with_preview(), <bang>0)

" FZF
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
nnoremap <silent> <Leader>gg    :GGrep<CR>

command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
" merge conflict commands in a 3-way-diff with: 1 - middle (BASE), 2 - left (LOCAL), 3 - right side (REMOTE)
" https://git-scm.com/docs/vimdiff/en
nnoremap <Leader>gj :diffget //3<CR>
nnoremap <Leader>gf :diffget //2<CR>

" display line movements unless preceded by a count whilst also recording jump points for movements larger than five lines:
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" LIGHTLINE
" register compoments:
call lightline#coc#register()

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
            \   'linter_checking': 'lightline#coc#status',
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
            \ 'gitbranch': 'GitBranch',
            \ }

function GitBranch()
    return " " . FugitiveHead()
endfunction

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
nnoremap <silent><Leader>bdo :Bdelete other<CR>
" bdelete buffers not visible in a window
nnoremap <silent><Leader>bdh :Bdelete hidden<CR>:redraw<CR>
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
let g:ctrlsf_populate_qflist = 1
nnoremap <Leader>n <Plug>CtrlSFCwordPath -hidden<CR>
vmap     <leader>N <Plug>CtrlSFVwordPath

" autocmd TerminalWinOpen *
"       \ if &buftype == 'terminal' |
"   \   resize 16 |
"   \   setlocal termwinsize=16x0 |
"   \   setlocal nowrap |
"   \ endif
" TERMINAL
if has('win32')
    noremap <Leader>p :tab term<CR>
else
    if executable('zsh')
        noremap <silent><leader>p :term ++rows=16<CR>
    else
        " set termwinsize=16x0
        noremap <silent><Leader>p :term ++rows=16<CR>source $HOME/.bash_profile<CR>clear<CR>
        " set noequalalways
        " noremap <silent><Leader>p :term<CR>
    endif
endif
" enter Terminal-Normal mode (for scrolling log output)
" https://stackoverflow.com/a/46822285/8981617
" Use CTRL W N to enter Terminal Normal Mode
" re-enter Terminal-Job mode by pressing i

" COC
" let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-docker', 'coc-diagnostic', 'coc-yank', 'coc-rust-analyzer', 'coc-yaml', 'coc-cmake', 'coc-clangd']
let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-docker', 'coc-rust-analyzer', 'coc-yaml', 'coc-cmake', 'coc-clangd', '@yaegassy/coc-ruff', 'coc-pyright']

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

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" call hierarchy
" nnoremap <silent> gl :call CocLocations('ccls','$ccls/call', {'hierarchy':v:true,'levels':5})<CR>
" nnoremap <silent> gL :call CocLocations('ccls','$ccls/call',{'callee':v:true,'levels':5})<cr>
nnoremap <silent> gl :call CocAction('showIncomingCalls')<CR>
" outline
nnoremap <silent><nowait> go :CocFzfList outline<CR>
" Search workspace symbols
nnoremap <silent><nowait> gs :<C-u>CocList -I symbols<cr>
" Show diagnostic info
nmap <silent> gI <Plug>(coc-diagnostic-info)

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
let g:any_jump_remove_comments_from_results = 0

" FZF CHECKOUT
let g:fzf_checkout_git_options = '--sort=-committerdate'
nnoremap <silent> <Leader>gc :GBranches<CR>

" Coc Explorer
nnoremap <silent> <Leader>o :CocCommand explorer --sources=file+ --width=50<CR>

" vim-slime
" spawns REPL environment
let g:slime_target = 'vimterminal'
let g:slime_vimterminal_cmd = 'python'
" Send whole file to slime via C-c C-x
" nnoremap <c-c><c-x> :%SlimeSend<cr>

" coc-yank
" show list with yanked lines
nnoremap <silent> <leader>y  :<C-u>CocList -A --normal yank<cr>

" vim-quickscope
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim indentLine
let g:indentLine_char = '▏'
" 0: highlight conceal color with your colorscheme
let g:indentLine_setColors = 0
" exclude filetypes
let g:indentLine_fileTypeExclude = ['coc-explorer']

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

" persistent undo in RAM /tmp/
" from https://bluz71.github.io/2021/09/10/vim-tips-revisited.html
let s:undodir = '/tmp/.undodir_' . $USER
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
