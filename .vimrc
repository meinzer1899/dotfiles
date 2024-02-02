" meinzer1899's VIMRC

" Vim guides
" https://google.github.io/styleguide/vimscriptguide.xml
" https://rbtnn.hateblo.jp/entry/2014/12/28/010913

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8
" This is vim, not vi.
if exists('+nocompatible')
    set nocompatible
endif

function! s:get_SID() abort
    return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeget_SID$')
endfunction
let s:SID = s:get_SID()
delfunction s:get_SID

let s:on_win = has('win32')
let s:on_mac = has('mac')

" Open new split panes to right and buttom
set splitbelow
set lazyredraw

" lightline shows the mode already
set noshowmode
" Show the statusbar always, not only on last window
set laststatus=2

" See the cursor line and the offset with the adjacent lines.
set number
if exists('+relativenumber')
    set relativenumber
endif

" No sounds
set visualbell
" disable the more-prompt
set nomore
" Reload files changed outside vim
set autoread
" Better to be noisy than find something unexpected.
set noautowrite

" Trigger checktime to get updates on file change more often
au FocusGained * :checktime

" Set Blowfish for encryption method, but only on Vim >=7.3.
if has('cryptv') && v:version >= 703 | set cryptmethod=blowfish | endif

" Show current mode down the bottom
set showmode
" Don't show commands as you type them
set noshowcmd

" Give more space for displaying messages.
set cmdheight=1

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=150

" Don't pass messages to |ins-completion-menu| (coc)
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Allow buffer switching even if unsaved
set hidden
" Don't display long lines that don't fit in the window as if were broken.
" Display long lines by showing them in multiple visual lines, not by scrolling.
" Only affects how the lines look. See 'showbreak' for the visual hint.
set wrap
" Wrap lines at convenient points. Only makes sense if wrap is enabled.
set linebreak
" help fo-table.  set fo=croq (only format comments, good for code), set fo=tcrq for text
set fo=croq
" Add 'j' (remove commentstring when joining) to format options.
if v:version > 703 | set fo+=j | endif
" Don't leave two spaces between two sentences (foo.  Bar) when joining lines
set nojoinspaces

" Fix Vim's ridiculous line wrapping model
set whichwrap=<,>,[,],h,l

" ================ Folds ============================

" fold based on indent
set foldmethod=indent
" deepest fold is 3 levels
set foldnestmax=3
" dont fold by default
set nofoldenable

"" ================ Indentation ======================
"
" tabstop: Set how many spaces _looks_ a tab.
set tabstop=4
" shiftwidth: Number of spaces to use for each step of (auto)indent.
" Usually you set it to the tabstop, unless you want to mix spaces and tabs.
set shiftwidth=4
" softtabstop: Makes the backspace more consistent with the tab in insert mode
" if you set the shiftwidth and the softtabstop the same value
set softtabstop=4
" On pressing tab, insert 4 spaces
set expandtab
set autoindent
" Make <Tab> and <BS> behave according to 'shiftwidth'.
set smarttab
set smartindent
" Use multiples of 'shiftwidth' when using the operators '>' and '<'.
set shiftround
" Allow the backspace to do useful things (is not the default everywhere)
set backspace=indent,eol,start

" Syntax highlighting reduced to some reasonable column.
set synmaxcol=500

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" Substitute what's under the cursor, or current selection.
" FIXME: escape regex character, like selecting /foo/bar and the slashes are
" there
nnoremap <leader>S :%s/\<<C-R><C-w>\>//c<left><left>
xnoremap <leader>S y:%s/<C-R>"//c<left><left>

" Load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Show some chars to denote clearly where there is a tab or trailing space
set list                                                                   " visualize non-visual characters
set listchars&                                                             "  '- set it to empty first
set listchars+=conceal:⌦                                                   "  '- what to show when concealing something
set listchars+=eol:\                                                       "  '- end of line
set listchars+=extends:\                                                   "  '- last column when wrap is off
set listchars+=nbsp:                                                       "  '- non-breaking space
set listchars+=precedes:\                                                  "  '- first column when wrap is off
set listchars+=tab:»\                                                      "  '- tab
set listchars+=trail:·                                                     "  '- trailing whitespace

" --- backup and swap files ---
set nobackup                                                               " no backups, I have persistent undo
set nowritebackup
set noswapfile

" persistent undo in RAM /tmp/
" from https://bluz71.github.io/2021/09/10/vim-tips-revisited.html
if has('persistent_undo')
    let s:undodir = '/tmp/.undodir_' . $USER
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p", 0740)
    endif
    let &undodir=s:undodir
    set undofile
    " persisent undo for 1024 actions
    set undolevels=1024
endif

" Save a lot more history
set history=200

" Use a colored column to mark the textwidh+1 column
set textwidth=80
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

" Highlight the opening bracket/parentheses when the closing one is written
set showmatch
set matchtime=3

" ================ Security ==========================
set modelines=0
set nomodeline

" ================ Completion =======================

" Activate completion of the command line.
set wildmenu
" Complete longest common string, then each full match
set wildmode=list:longest,list:full
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
set wildignore+=*/.nx/**,*.app,*.git,.git,*/__pycache__/**,__pycache__,*/.svn/*,*.DS_Store
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*

" Ignore case in the command line.
if exists('+wildignorecase') | set wildignorecase | endif

" ================ Scrolling ========================

" Make the text scroll some lines before the cursor reaches the border
set scrolloff=5
set sidescrolloff=15
set sidescroll=1

let g:mapleader = ' '
nnoremap <silent> \g :GitGutterToggle<CR>
nnoremap <silent> \p :ProseMode<CR>
nnoremap <silent> <Leader>s :update<CR>
nnoremap <silent> <Leader>gs :vertical :Git <CR>:vertical resize 45<CR>:setlocal winfixwidth<CR>
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
" ci( or ci{ does not jump automatically to parenthesis, fix with this these
" lines
nnoremap ci( f(ci(
nnoremap cI( F(ci(
nnoremap ci) f)ci)
nnoremap cI) F)ci)
nnoremap ci{ f{ci{
nnoremap cI{ F{ci{
nnoremap ci} f}ci}
nnoremap cI} F}ci}
nnoremap ci" f"ci"
nnoremap cI" F"ci"
nnoremap ci< f<ci<
nnoremap cI< F<ci<
nnoremap cI> F>ci>
nnoremap cI> F>ci>
" Make Y consistent with C and D.  See :help Y.
nnoremap Y y$

" Return to the previous cursor position
" " --------------------------------------
" "   '' returns to the previous line
" "   `` returns to the previous line and position
" " --------------------------------------
" " I never want #1 so I make it a nop and map #2 to #1
map '' <nop>
map '' ``

" my redraw key does a few things:
"   - remove hlsearch
"   - remove hlnext,
"   - clear highlighted yanks
"   - clear highlighted lines
"   - clear highlighted CurrentWord*
"   - clear highlighted InterestingWords
"   - reset colorcolumn
"   - redraw screen
nnoremap <silent> <C-l>
            \ :call HLNextOff()                   <BAR>
            \ :nohl                               <BAR>
            \ :hi clear YankedMatches             <BAR>
            \ :call HighlightCurrentLine('clear') <BAR>
            \ :set colorcolumn&                   <BAR>
            \ :redraw <CR>

" diffopt
set diffopt=filler,context:3,iwhite,hiddenoff
if has('nvim-0.3.2') || has('patch-8.1.0360')
    " https://old.reddit.com/r/vim/comments/cn20tv/tip_histogrambased_diffs_using_modern_vim/
    set diffopt+=internal,algorithm:histogram,indent-heuristic
endif

" Set the characters for statusline (& non current stl), vsplit, fold & diff.
" " TODO: some characters don't work with some colorschemes because use bold,
" etc.
" set fillchars=vert:┃,fold:=,diff:·
set fillchars=vert:┃,fold:═,diff:·

" https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character
set selection=exclusive

" Don't render (auto-format) markdown syntax
set conceallevel=0

" Limit suggestions when spell checking with z=.
set spellsuggest=best,15

" Vimrc augroup
augroup MyVimrc
    " Clear all autocommands in the group to avoid defining them multiple
    " times each time vimrc is reloaded. It has to be only once and at the
    " beginning of each augroup.
    autocmd!
augroup END

command! -nargs=+ Autocmd autocmd MyVimrc <args>
command! -nargs=+ AutocmdFT autocmd MyVimrc FileType <args>
Autocmd VimEnter,WinEnter .vimrc,.gvimrc,vimrc,gvimrc syn keyword myVimAutocmd Autocmd AutocmdFT contained containedin=vimIsCommand
Autocmd ColorScheme * highlight def link myVimAutocmd vimAutoCmd

Autocmd VimResized * wincmd =
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or
" when inside an event handler (happens when dropping a file on gvim).
Autocmd BufReadPost *
                \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g`\"" |
                \ endif

Autocmd BufRead,BufNewFile *.md setlocal filetype=markdown
Autocmd BufRead,BufNewFile *.plantuml setlocal filetype=plantuml
Autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
Autocmd BufRead,BufNewFile aliases.local,zshrc.local,*/zsh/configs/* set filetype=zsh
Autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
Autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
Autocmd BufRead,BufNewFile vimrc.local set filetype=vim
Autocmd BufRead,BufNewFile .vimrc set filetype=vim
Autocmd BufRead,BufNewFile CMakeLists.txt set filetype=cmake
Autocmd BufRead,BufNewFile *.tpp set filetype=cpp
AutocmdFT cpp setlocal matchpairs+=<:>
Autocmd BufRead,BufNewFile .clang-format set filetype=yaml
AutocmdFT {markdown,gitcommit} setlocal spell spelllang=en_us
" Update signature help on jump placeholder.
Autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" Autocmd User CocLocationsChange call s:coc_qf_jump2loc(g:coc_jump_locations)
" Highlight the symbol and its references
Autocmd CursorHold * silent call CocActionAsync('highlight')
" Start in INSERT mode if opening commit message with empty first line
" Autocmd VimEnter COMMIT_EDITMSG if getline(1) == '' | execute 1 | startinsert | endif
AutocmdFT gitcommit startinsert!
" disable automatic comment on newline
AutocmdFT * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" number column may cause ugly formatting when entering terminal window via C-w N :(
Autocmd TerminalWinOpen * setlocal signcolumn=no textwidth=0 winfixheight norelativenumber nonumber

" vim as MANPAGER
" https://muru.dev/2015/08/28/vim-for-man.html
" MAN_PN is set to the manpage name
if !empty($MAN_PN)
    Autocmd StdinReadPost * set ft=man | file $MAN_PN
endif

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim')) && empty($MAN_PN)
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  Autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
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
" Plug 'catppuccin/vim', { 'as': 'catppuccin' }
" Plug 'Everblush/everblush.vim'
" let g:everblush_transp_bg = 1
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
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
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
let g:sneak#use_ic_scs = 1
Plug 'kana/vim-niceblock'
Plug 'z-shell/zi-vim-syntax'
Plug 'machakann/vim-highlightedundo'
nmap u     <Plug>(highlightedundo-undo)
nmap <C-r> <Plug>(highlightedundo-redo)
nmap U     <Plug>(highlightedundo-Undo)
nmap g-    <Plug>(highlightedundo-gminus)
nmap g+    <Plug>(highlightedundo-gplus)

" Initialize plugin system
call plug#end()

" COLORS
" from https://github.com/rhysd/dogfiles/blob/ba7624a7391da033fb328eaa67bb5743368dab4e/vimrc#L1120
if !has('gui_running') && $TMUX !=# ''
    set t_Co=256
endif

syntax enable

if !has('gui_running')
    if &t_Co < 256
        set background=dark
        colorscheme default
    else
        " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
        if has('termguicolors') && $COLORTERM ==# 'truecolor'
            let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
            let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
            set termguicolors
            set background=dark
            colorscheme onedark
            let g:lightline = { 'colorscheme': 'onedark' }
        endif
    endif
endif

" CLIPBOARD
if has('macunix') || s:on_win
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
nnoremap <silent> <Leader>bl     :Lines<CR>
nnoremap <silent> <Leader>l    :BLines<CR>
nnoremap <silent> <Leader>gf    :GFiles?<CR>
nnoremap <silent> <Leader>h     :History:<CR>
nnoremap <silent> <Leader>c     :Commits<CR>
" commits for the current buffer, or current line if a line is selected
nnoremap <silent> <Leader>bc    :BCommits<CR>
vnoremap <silent> <Leader>bc    :BCommits<CR>
nnoremap <silent> <Leader>gg    :GGrep<CR>

command! -bang -nargs=* GGrep
            \ call fzf#vim#grep(
            \   'git grep --line-number -- '.fzf#shellescape(<q-args>),
            \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" merge conflict commands in a 3-way-diff with: 1 - middle (BASE), 2 - left (LOCAL), 3 - right side (REMOTE)
" https://git-scm.com/docs/vimdiff/en
nnoremap <Leader>gj :diffget //3<CR>
nnoremap <Leader>gf :diffget //2<CR>

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
Autocmd VimEnter,FilterWritePre * if &diff | GitGutterDisable | endif

" BUFFERS
" bdelete all buffers except the buffer in the current window
nnoremap <silent><Leader>bdo :Bdelete other<CR>
" bdelete buffers not visible in a window
nnoremap <silent><Leader>bdh :Bdelete hidden<CR>:redraw<CR>
" Clear and redraw the screen. Defaulted to <C-L>.
nmap <C-L> :redraw!<CR>

" Disable rnumbers on inactive buffers for active screen indication
" but not for terminal buffers because of ugly formatting when leaving and
" entering normal mode in a terminal.
Autocmd WinEnter * if &buftype !~# 'terminal' | set relativenumber | endif
Autocmd WinLeave * if &buftype !~# 'terminal' | set norelativenumber | endif

" HIGHLIGHT
highlight StatusLineNC cterm=bold ctermfg=white ctermbg=darkgray
" highlight the matches that have been yanked to a register and
" the system clipboard
highlight YankedMatches ctermfg=bg ctermbg=196 cterm=bolditalic
highlight HighlightedyankRegion ctermfg=bg ctermbg=185 cterm=bolditalic

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
if s:on_win
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
" let g:coc_global_extensions = ['coc-explorer', 'coc-json', 'coc-docker', 'coc-rust-analyzer', 'coc-yaml', 'coc-cmake', 'coc-clangd', '@yaegassy/coc-ruff', 'coc-pyright', 'coc-yank']
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

nnoremap <silent><nowait> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent><nowait> gi :call CocActionAsync('jumpImplementation')<CR>
nnoremap <silent><nowait> gt :call CocActionAsync('jumpTypeDefinition')<CR>
nnoremap <silent><nowait> gr :call CocActionAsync('jumpReferences')<CR>
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gt <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-refactor)

if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" from https://github.com/fannheyward/init.vim/blob/f91875ebb7fabf831086e66b9c11dd5240e8c859/init.vim#L256
function! s:coc_qf_diagnostic() abort
  if !get(g:, 'coc_service_initialized', 0)
    return
  endif
  let diagnostic_list = CocAction('diagnosticList')
  let items = []
  let loc_ranges = []
  for d in diagnostic_list
    let text = printf('[%s%s] %s', (empty(d.source) ? 'coc.nvim' : d.source), (has_key(d, 'code') ? ' ' . d.code : ''), split(d.message, '\n')[0])
    let item = {'filename': d.file, 'lnum': d.lnum, 'end_lnum': d.end_lnum, 'col': d.col, 'end_col': d.end_col, 'text': text, 'type': d.severity[0]}
    call add(loc_ranges, d.location.range)
    call add(items, item)
  endfor
  call setqflist([], ' ', {'title': 'CocDiagnosticList', 'items': items, 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
  botright copen
endfunction

" from https://github.com/fannheyward/init.vim/blob/f91875ebb7fabf831086e66b9c11dd5240e8c859/init.vim#L273
function! s:coc_qf_jump2loc(locs) abort
    let loc_ranges = map(deepcopy(a:locs), 'v:val.range')
    call setloclist(0, [], ' ', {'title': 'CocLocationList', 'items': a:locs, 'context': {'bqf': {'lsp_ranges_hl': loc_ranges}}})
    let winid = getloclist(0, {'winid': 0}).winid
    if winid == 0
        rightbelow lwindow
    else
        call win_gotoid(winid)
    endif
endfunction

" call hierarchy
" nnoremap <silent> gl :call CocLocations('ccls','$ccls/call', {'hierarchy':v:true,'levels':5})<CR>
" nnoremap <silent> gL :call CocLocations('ccls','$ccls/call',{'callee':v:true,'levels':5})<cr>
nnoremap <silent> gl :call CocAction('showIncomingCalls')<CR>
" outline
nnoremap <silent><nowait> go  :<C-u>CocList -A outline -kind<CR>
" Search workspace symbols
nnoremap <silent><nowait> gs :<C-u>CocList -I symbols<cr>
" Show diagnostic info
nnoremap <silent><nowait> gI <Plug>(coc-diagnostic-info)
" Show coc diagnostics in quickfix
nnoremap <silent><nowait> gq  :call <SID>coc_qf_diagnostic()<CR>

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
" exclude filetypes
let g:indentLine_fileTypeExclude = ['coc-explorer', 'man', 'COMMIT_EDITMSG']
let g:indentLine_bufTypeExclude = ['help', 'terminal']
" (default: 2)
let g:indentLine_color_dark = 1

" coc-fzf
let g:coc_fzf_preview = 'right:40%'

" vim-agriculture
" search word under cursor
vnoremap <Leader>rr <Plug>RgRawVisualSelection<cr>

" rainbow parenthesis
" rainbow breakes cmake syntax highlighting
" https://github.com/luochen1990/rainbow/issues/77
let g:rainbow_conf = {
\   'separately': {
\       'cmake': 0,
\   }
\}

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
