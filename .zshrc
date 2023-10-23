if [[ -r "$HOME/.config/zi/init.zsh" ]]; then
  source "$HOME/.config/zi/init.zsh" && zzinit
fi

# environment variables
export EDITOR=vim

# https://wiki.zshell.dev/community/gallery/collection/themes
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor
# When running: zi update will:
#     if an update is available, will update the fonts.
#     repeat the install process to update fonts.
zi ice if"[[ -d ${HOME}/.local/share/fonts ]] && [[ $OSTYPE = linux* ]]" \
  id-as"JetBrainsMono" from"gh-r" bpick"JetBrainsMono.zip" extract nocompile depth"1" \
  atclone="rm -f *Windows*; mv -vf *.ttf ${HOME}/.local/share/fonts; fc-cache -v -f" atpull"%atclone"
zi light ryanoasis/nerd-fonts

### annexes
zi light-mode for z-shell/z-a-meta-plugins @annexes @rust-utils
zi light z-shell/z-a-bin-gem-node

# https://wiki.zshell.dev/community/gallery/collection/snippets
zi wait lucid for \
  OMZL::git.zsh \
  atload"unalias grv" \
  OMZP::git \
  OMZL::completion.zsh

zi light-mode for compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' atload" \
  PURE_PROMPT_SYMBOL='▶'; PURE_PROMPT_VICMD_SYMBOL='◀'; \
  zstyle ':prompt:pure:git:stash' show 'yes'" \
  sindresorhus/pure

zi wait lucid for \
  OMZP::fancy-ctrl-z

# fast toolchain as code for JS (e.g. node)
# volta is much faster than nvm, thus nvm is replaced
zi light cowboyd/zsh-volta

zi wait lucid for atload"ZSH_PLUGINS_ALIAS_TIPS_TEXT='Has alias: '" @djui/alias-tips

### programs

## rust
## https://wiki.zshell.dev/ecosystem/annexes/rust
#Install rust and make it available globally in the system:
zi id-as"rust" wait=1 as=null sbin="bin/*" lucid rustup nocompile \
  atload="[[ ! -f ${ZI[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall -q rust; \
  export CARGO_HOME=\$PWD; export RUSTUP_HOME=\$PWD/rustup" for \
  z-shell/0

zi wait lucid as'program' from'gh-r' for \
  atclone'ln -s bat/autocomplete/bat.zsh -> _bat; cp -vf bat/*.1 $ZI[MAN_DIR]/man1' \
  atpull'%atclone' \
  mv'bat* -> bat' sbin'**/bat(.exe|) -> bat' \
  pick'$ZPFX/bin/bat' \
  @sharkdp/bat

zi wait lucid as'program' from'gh' has'bat' pick'src/*' for \
  @eth-p/bat-extras

zi wait lucid as'program' from'gh-r' for \
  atclone'ln -s fd/autocomplete/_fd -> _fd; cp -vf fd/*.1 $ZI[MAN_DIR]/man1' \
  atpull"%atclone" \
  mv'fd* -> fd' sbin'**/fd(.exe|) -> fd' \
  pick'$ZPFX/bin/fd' \
  @sharkdp/fd

zi wait lucid as'program' from'gh-r' for \
  mv'delta* -> delta' \
  sbin'**/delta -> delta' \
  pick'$ZPFX/bin/delta' \
  @dandavison/delta 

# last updated 3 yrs ago...
zi ice wait lucid as'completion' blockf has'delta'
zi snippet https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh

# important: gh, not gh-r because app gets release infrequently
zi wait lucid as'program' from'gh' for \
  atclone'cargo build --release; \
	  ln -s completions/zsh/_exa -> _exa; \
	  cp -vf man/*.1.* $ZI[MAN_DIR]/man1; cp -vf man/*.5.* $ZI[MAN_DIR]/man5' \
  atpull"%atclone" \
  sbin'**/exa -> exa' \
  pick'$ZPFX/bin/exa' \
  @ogham/exa

zi wait lucid for \
  has'exa' atinit'AUTOCD=1' \
  @zplugin/zsh-exa

# completions only available in debug build
zi wait lucid as'program' from'gh' for \
  atclone'cargo build --release --features "pcre2"' \
  atpull'%atclone' \
  sbin'**/rg -> rg' \
  pick'$ZPFX/bin/rg' \
  @BurntSushi/ripgrep

zi ice wait lucid as'completion' blockf has'rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

zi wait lucid as'program' from'gh-r' for \
  mv'tealdeer* -> tealdeer' \
  sbin'**/tealdeer -> tldr' \
  pick'$ZPFX/bin/tldr' \
  @dbrgn/tealdeer

zi ice wait lucid as'completion' blockf has'tldr' mv'zsh_tealdeer -> _tldr'
zi snippet https://github.com/dbrgn/tealdeer/blob/main/completion/zsh_tealdeer

### zi pack

# Install latest zsh
zi pack for zsh

# FZF
# Download the package with the bin-gem-node annex-utilizing ice list
# + setting up the key bindings. The "+keys" variants are available for each profile
# zi pack"bgn+keys" for fzf # did not update fzf binary (was 0.30.0 when 0.38.0 (>1year) was available
zi wait lucid for atclone'mkdir -p $ZPFX/{bin,man/man1}' atpull'%atclone' from'gh-r' dl'
  https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf;
  https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/man/man1/fzf-tmux.1;
  https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/man/man1/fzf.1;
  https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh' \
    id-as'junegunn/fzf' nocompile pick'/dev/null' sbin'fzf' src'key-bindings.zsh' \
    junegunn/fzf
# For fzf-tmux to find fzf executable, change
#   `fzf="$(command -v fzf 2> /dev/null)" || fzf=$HOME/.zi/polaris/bin/fzf`

zi ice lucid wait"0b" pick'fzf-git.sh'
zi load junegunn/fzf-git.sh

# The following example uses tree command to show the entries of the directory.
export FZF_ALT_C_OPTS="--preview 'exa -1 --icons --group-directories-first --color=always --all {} | head -200'"
# follow symbolic links and don't exclude hidden files
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --no-ignore-vcs --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Narrow down the list with a query, point to a command,
# and hit CTRL-T to see its surrounding commands.
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-/:toggle-preview'
--bind 'ctrl-t:track+clear-query'
--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"

### pip
# https://wiki.zshell.dev/ecosystem/annexes/bin-gem-node#pip-5
zi ice pip'cmake-language-server <- !cmake-language-server -> cmake-language-server' id-as'cmake-language-server' nocompile
zi load z-shell/0

zi ice pip'ruff <- !ruff -> ruff' id-as'ruff' nocompile
zi load z-shell/0

# --cmd x is important as zoxide uses z _and_ zi.
# zi is used for zsh zi
# if remapped, source this file ~/.zi/bin/zi.zsh
# zi ice as'program' from'gh-r' pick'zoxide' \
#   atclone'ln -s completions/_zoxide -> _zoxide;
#   cp man/man1/*.1 $ZI[MAN_DIR]/man1; ./zoxide init zsh --cmd x > init.zsh' \
#   atpull'%atclone' src'init.zsh' nocompile'!'
zi ice as'null' from"gh-r" sbin
zi light ajeetdsouza/zoxide
zi has'zoxide' wait lucid for \
  z-shell/zsh-zoxide

zi ice wait lucid as'completion' blockf has'zoxide'
zi snippet https://github.com/ajeetdsouza/zoxide/blob/main/contrib/completions/_zoxide

  # atpull'%atclone' make'all install' pick'$ZPFX/bin/vim'
zi ice as'program' atclone'rm -f src/auto/config.cache; \
  ./configure --prefix=$ZPFX --enable-python3interp=yes' \
  atpull'%atclone' make pick'$ZPFX/bin/vim'
zi light vim/vim

zi wait lucid as'program' from'gh-r' for \
  mv'shellcheck* -> shellcheck' \
  sbin'**/shellcheck -> shellcheck' \
  @koalaman/shellcheck

# pick'$ZPFX/bin/shellcheck' \
### completions
zi ice wait lucid as'completion' blockf mv'git-completion.zsh -> _git'
zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

zi ice wait lucid as"completion"
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi ice wait lucid as'completion' blockf has'alacritty'
zi snippet https://github.com/alacritty/alacritty/blob/master/extra/completions/_alacritty

zi ice wait lucid as'completion' blockf has'cargo'
zi snippet https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo
zi ice wait lucid as'completion' blockf has'rustc'
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rust/_rustc

# only for git
# zstyle ':completion:*:*:git:*' fzf-search-display true
# or for everything
zstyle ':completion:*' fzf-search-display true

# fzf-tab completions from https://github.com/Aloxaf/fzf-tab/wiki/Preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --icons --group-directories-first --color=always $realpath'
# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false
# use input as query string when completing zlua
zstyle ':fzf-tab:*' single-group ''
# preview git commands
# it is an example. you can change it
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'

# fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!
zi ice wait lucid has'fzf'
zi light Aloxaf/fzf-tab

# Utilize Turbo and initialize the completion with fast compinit
# zi wait pack atload=+"zicompinit_fast; zicdreplay" for system-completions
# Utilize Turbo
zi wait pack for system-completions

# load this completions last -> https://wiki.zshell.dev/docs/guides/commands#calling-compinit-with-turbo-mode and https://wiki.zshell.dev/ecosystem/plugins/f-sy-h#-z-shellf-sy-h
zi wait lucid for \
  atinit"ZI[COMPINIT_OPTS]=-C; zicompinit_fast; zicdreplay" \
  zsh-users/zsh-syntax-highlighting \
  blockf \
  zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions

export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# https://wiki.zshell.dev/docs/guides/customization#history-optimization
setopt append_history         # Allow multiple sessions to append to one Zsh command history.
setopt extended_history       # Show timestamp in history.
setopt hist_expire_dups_first # Expire A duplicate event first when trimming history.
setopt hist_find_no_dups      # Do not display a previously found event.
setopt hist_ignore_all_dups   # Remove older duplicate entries from history.
setopt hist_ignore_dups       # Do not record an event that was just recorded again.
setopt hist_ignore_space      # Do not record an Event Starting With A Space.
setopt hist_reduce_blanks     # Remove superfluous blanks from history items.
setopt hist_save_no_dups      # Do not write a duplicate event to the history file.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
setopt share_history          # Share history between different instances of the shell.

# https://wiki.zshell.dev/docs/guides/customization#other-tweaks
setopt auto_cd              # Use cd by typing directory name if it's not a command.
setopt auto_list            # Automatically list choices on ambiguous completion.
setopt auto_pushd           # Make cd push the old directory onto the directory stack.
setopt bang_hist            # Treat the '!' character, especially during Expansion.
setopt interactive_comments # Comments even in interactive shells.
setopt multios              # Implicit tees or cats when multiple redirections are attempted.
setopt no_beep              # Don't beep on error.
setopt prompt_subst         # Substitution of parameters inside the prompt each time the prompt is drawn.
setopt pushd_ignore_dups    # Don't push multiple copies directory onto the directory stack.
setopt pushd_minus          # Swap the meaning of cd +1 and cd -1 to the opposite.

# https://wiki.zshell.dev/docs/guides/customization#other-tweaks
# Fuzzy completion matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
# Allow more errors for longer commands
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

# # https://wiki.zshell.dev/docs/guides/customization#pretty-completions
# zstyle ':completion:*:matches' group 'yes'
# zstyle ':completion:*:options' description 'yes'
# zstyle ':completion:*:options' auto-description '%d'
# zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
# zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
# zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# zstyle ':completion:*' use-cache true
# zstyle ':completion:*' rehash true

# # Complete manual by their section
# zstyle ':completion:*:manuals' separate-sections true
# zstyle ':completion:*:manuals.*' insert-sections true
# zstyle ':completion:*:man:*' menu yes select

# Use cache for slow functions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZDOTDIR/cache
# Ignore completion for non-existant commands
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# https://wiki.zshell.dev/docs/guides/customization#do-menu-driven-completion
# zstyle ':completion:*' menu select

# Smart case-y completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Dircolors on completions
# https://wiki.zshell.dev/docs/guides/customization#color-completion-for-some-things
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

### bindings

bindkey -e
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey "^H" autosuggest-execute
# common bind
bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^d' delete-char-or-list
bindkey '^e' end-of-line
bindkey '^f' forward-char
# bindkey '^g' send-break # interferes with fzf-git.sh
bindkey '^w' backward-kill-word
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^y' yank
bindkey '^q' show-buffer-stack

### alias
alias v="vim"
alias nv="nvim"
# alias man="batman.sh"
export MANPAGER="vim +MANPAGER --not-a-term -"
