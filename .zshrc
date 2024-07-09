# See man zshell for all settings

# zinit loader
if [[ -r "${XDG_CONFIG_HOME:-${HOME}/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-${HOME}/.config}/zi/init.zsh" && zzinit
fi

# https://wiki.zshell.dev/community/gallery/collection/themes
[[ $COLORTERM = *(24bit|truecolor)* ]] || zmodload zsh/nearcolor

# When running: zi update will:
#     if an update is available, will update the fonts.
#     repeat the install process to update fonts.
zi ice if"[[ -d ${HOME}/.local/share/fonts ]] && [[ $OSTYPE = linux* ]]" \
  id-as'JetBrainsMono' from'gh-r' bpick'JetBrainsMono.tar.xz' extract nocompile depth'1' \
  atclone="rm -f *Windows*; mv -vf *.ttf ${HOME}/.local/share/fonts; fc-cache -v -f" atpull'%atclone'
zi light ryanoasis/nerd-fonts

### annexes
zi light-mode for z-shell/z-a-meta-plugins @annexes
zi light-mode for z-shell/z-a-bin-gem-node

# https://wiki.zshell.dev/community/gallery/collection/snippets
zi wait lucid for \
  OMZL::git.zsh \
  atload'unalias grv' \
  OMZP::git \
  OMZL::completion.zsh \
  OMZP::cp

# Setup ssh agent (vs code uses this to share git credentials in devcontainer)
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/ssh-agent/README.md
zi wait lucid for \
  atload'zstyle :omz:plugins:ssh-agent agent-forwarding yes; \
  zstyle :omz:plugins:ssh-agent lazy yes; \
  zstyle :omz:plugins:ssh-agent identities id_ed25519' \
  OMZP::ssh-agent

# :prompt:pure:prompt:* changes the color for both `prompt:success` and `prompt:error`
zi light-mode for compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh' atload" \
  PURE_PROMPT_SYMBOL='▶'; PURE_PROMPT_VICMD_SYMBOL='◀'; \
  zstyle ':prompt:pure:git:stash' show 'yes'; \
  zstyle ':prompt:pure:prompt:*' color 'magenta'; \
  " \
  sindresorhus/pure

zi wait'0b' lucid for \
  as'program' pick'neofetch' \
  atclone'cp neofetch.1 $ZI[MAN_DIR]/man1' atpull'%atclone' \
  dylanaraps/neofetch

zi wait'0b' lucid for \
  OMZP::fancy-ctrl-z

# fast toolchain as code for JS (e.g. node)
# volta is much faster than nvm, thus nvm is replaced
zi light cowboyd/zsh-volta
# completions not working :(
# zi wait lucid for \
#   OMZP::volta

zi wait'0b' lucid for \
 atload"ZSH_PLUGINS_ALIAS_TIPS_TEXT='Has alias: '" \
 @djui/alias-tips

### programs
zi wait lucid as'program' from'gh-r' for \
  mv'hadolint* hadolint' \
  sbin'hadolint' \
  @hadolint/hadolint

## rust
## https://wiki.zshell.dev/ecosystem/annexes/rust
#Install rust and make it available globally in the system:
zi id-as'rust' wait=1 as=null sbin='bin/*' lucid rustup nocompile \
  atload="[[ ! -f ${ZI[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall -q rust; \
  export CARGO_HOME=\$PWD; export RUSTUP_HOME=\$PWD/rustup" for \
  z-shell/0

zi ice wait lucid as'completion' blockf has'cargo'
zi snippet https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo
zi ice wait lucid as'completion' blockf has'rustc'
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rust/_rustc

zi wait lucid as'program' from'gh-r' for \
  atclone'ln -sf bat/autocomplete/bat.zsh _bat; cp -vf bat/*.1 $ZI[MAN_DIR]/man1' \
  atpull'%atclone' \
  mv'bat* bat' sbin'**/bat(.exe|) bat' \
  @sharkdp/bat

zi wait lucid as'program' from'gh' has'bat' pick'src/*' for \
  @eth-p/bat-extras

zi wait lucid as'program' from'gh-r' for \
  atclone'ln -sf fd/autocomplete/_fd _fd; cp -vf fd/*.1 $ZI[MAN_DIR]/man1' \
  atpull'%atclone' \
  mv'fd* fd' sbin'**/fd(.exe|) fd' \
  @sharkdp/fd

zi wait lucid as'program' from'gh-r' for \
  mv'delta* delta' \
  sbin'**/delta delta' \
  @dandavison/delta

# last updated 3 yrs ago...
zi ice wait lucid as'completion' blockf has'delta'
zi snippet https://raw.githubusercontent.com/dandavison/delta/master/etc/completion/completion.zsh

# gh, because of completions and man pages
zi wait lucid as'program' from'gh' for \
  atclone'cargo build --release; \
	  ln -sf completions/zsh/_eza _eza; \
	  cp -vf man/*.1.* $ZI[MAN_DIR]/man1; cp -vf man/*.5.* $ZI[MAN_DIR]/man5' \
  atpull'%atclone' \
  sbin'target/release/eza eza' \
  @eza-community/eza

zi wait lucid for \
  has'eza' atinit'AUTOCD=1' \
  @z-shell/zsh-eza

# speed improvement: disable default maps and bindkey manually
zi wait lucid for \
  atinit'ZSH_SYSTEM_CLIPBOARD_TMUX_SUPPORT=true; \
  ZSH_SYSTEM_CLIPBOARD_DISABLE_DEFAULT_MAPS=true;
  # Bind Y to yank until end of line \
  bindkey -M vicmd Y zsh-system-clipboard-vicmd-vi-yank-eol; \
  ' \
  @kutsan/zsh-system-clipboard

# manpages only available in debug build
# https://github.com/BurntSushi/ripgrep/blob/master/FAQ.md#manpage
zi wait lucid as'program' from'gh-r' for \
  atclone'ln -sf ripgrep/complete/_rg _rg; cp -vf ripgrep/doc/*.1 $ZI[MAN_DIR]/man1' \
  atpull'%atclone' \
  mv'ripgrep* ripgrep' sbin'**/rg(.exe|) rg' \
  @BurntSushi/ripgrep

zi wait lucid as'program' from'gh-r' for \
  mv'tealdeer* tealdeer' \
  sbin'**/tealdeer tldr' \
  @dbrgn/tealdeer

zi ice wait lucid as'completion' blockf has'tldr' mv'zsh_tealdeer _tldr'
zi snippet https://github.com/dbrgn/tealdeer/blob/main/completion/zsh_tealdeer

zi wait lucid as'program' from'gh-r' for \
  mv'neocmakelsp* neocmakelsp' \
  sbin'**/neocmakelsp' \
  @Decodetalkers/neocmakelsp

# FZF
# Download the package with the bin-gem-node annex-utilizing ice list
# + setting up the key bindings. The "+keys" variants are available for each profile
# zi pack"bgn+keys" for fzf # did not update fzf binary (was 0.30.0 when 0.38.0 (>1year) was available
zi wait lucid for atclone'mkdir -p $ZPFX/{bin,man/man1}' atpull'%atclone' from'gh-r' dl'
  https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh -> _fzf;
  https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf-tmux.1 -> $ZPFX/man/man1/fzf-tmux.1;
  https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/man/man1/fzf.1;
  https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-preview.sh -> fzf-preview.sh;
  https://raw.githubusercontent.com/junegunn/fzf/master/bin/fzf-tmux -> fzf-tmux;
  https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh -> key-bindings.zsh' \
    id-as'junegunn/fzf' nocompile pick'/dev/null' sbin'fzf(|-tmux)' src'key-bindings.zsh' \
    junegunn/fzf

# zi ice lucid wait"0b" pick'fzf-git.sh'
# zi load junegunn/fzf-git.sh

export FZF_DEFAULT_COMMAND="command fd --type f --strip-cwd-prefix --hidden --follow --no-ignore-vcs --exclude .git || git ls-tree -r --name-only HEAD || rg --files --hidden --follow --glob '!.git' || find ."
# The following example uses tree command to show the entries of the directory.
export FZF_ALT_C_OPTS="--preview 'eza -1 --icons=always --group-directories-first --color=always --all {} | head -200'"
export FZF_ALT_C_COMMAND='command fd --hidden --no-ignore-vcs --exclude .git --type d'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Narrow down the list with a query, point to a command,
# and hit CTRL-T to see its surrounding commands.
# copy command with CTRL-Y (https://github.com/junegunn/fzf/blob/6b99399c41d9818ee4b4fa8968a1249100008e4c/README.md?plain=1#L588)
export FZF_CTRL_R_OPTS="
--preview 'echo {}' --preview-window up:3:hidden:wrap
--bind 'ctrl-p:toggle-preview'
--bind 'ctrl-t:track+clear-query'
--bind 'ctrl-y:execute-silent(echo -n {2..} | xclip -i -selection clipboard)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard | CTRL-p to toggle full command preview'
"

# Set --walker options without 'follow' not to follow symbolic links
FZF_COMPLETION_PATH_OPTS="--walker=file,dir,hidden"
FZF_COMPLETION_DIR_OPTS="--walker=dir,hidden"

export FZF_DEFAULT_COLORS="\
  --color=dark
  --color gutter:-1,selected-bg:238,selected-fg:146,current-fg:189
"

export FZF_DEFAULT_OPTS="\
  $FZF_DEFAULT_COLORS\
  --no-mouse
  --height='40%'
  --margin='1,3'
  --layout='reverse'
  --pointer ▶ --prompt ' '
  --info='inline'
  --no-separator
  --no-bold
  --bind ctrl-d:half-page-down
  --bind ctrl-u:half-page-up
  --bind alt-a:toggle-all
"

# execute: after exiting $EDITOR, fzf search is still open
# become: opens $EDITOR in new process and exits old process (-> fzf search not visible after exiting)
export FZF_CTRL_T_OPTS="\
  --preview '(bat --style=numbers --color=always {} || cat {} || tree -NC {}) 2> /dev/null | head -200'
  --bind 'ctrl-v:become($EDITOR {} < /dev/tty > /dev/tty)'
"

### pip
# https://wiki.zshell.dev/ecosystem/annexes/bin-gem-node#pip-5
zi ice has'pip' pip'ruff <- !ruff -> ruff' id-as'ruff' nocompile
zi load z-shell/0
zi ice has'pip' pip'ruff-lsp <- !ruff-lsp -> ruff-lsp' id-as'ruff-lsp' nocompile
zi load z-shell/0

# --cmd x is important as zoxide uses z _and_ zi.
# zi is used for zsh zi
# if remapped, source this file ~/.zi/bin/zi.zsh
# zi ice as'program' from'gh-r' pick'zoxide' \
#   atclone'ln -sf completions/_zoxide _zoxide;
#   cp man/man1/*.1 $ZI[MAN_DIR]/man1; ./zoxide init zsh --cmd x > init.zsh' \
#   atpull'%atclone' src'init.zsh' nocompile'!'
zi ice as'null' from'gh-r' sbin
zi light ajeetdsouza/zoxide
zi has'zoxide' wait lucid for \
  z-shell/zsh-zoxide

zi ice wait lucid as'completion' blockf has'zoxide'
zi snippet https://github.com/ajeetdsouza/zoxide/blob/main/contrib/completions/_zoxide

# https://wiki.zshell.dev/docs/guides/syntax/standard#as'program'
zi ice as'program' atclone'rm -f src/auto/config.cache; \
  ./configure --quiet --prefix=$ZPFX --enable-python3interp=yes --enable-luainterp=yes' \
  atpull'%atclone' make'all install' pick'$ZPFX/bin/vim'
zi light vim/vim

zi wait lucid as'program' from'gh-r' for \
  mv'shellcheck* shellcheck' \
  sbin'**/shellcheck shellcheck' \
  @koalaman/shellcheck

# grex generates regular expressions from user-provided test cases
zi wait lucid as'command' from'gh-r' for \
  sbin'grex' \
  @pemistahl/grex

## completions
# https://zsh.sourceforge.io/Guide/zshguide06.html

zi ice wait lucid as'completion'
zi snippet OMZP::gitfast

zi ice wait lucid as'completion'
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi ice wait lucid as'completion' blockf has'alacritty'
zi snippet https://github.com/alacritty/alacritty/blob/master/extra/completions/_alacritty

### PLUGINS WHICH HAS TO BE LOADED LAST

# fzf-tab needs to be loaded after compinit, but before plugins which will wrap widgets, such as zsh-autosuggestions or fast-syntax-highlighting!!
zi ice wait lucid has'fzf' blockf
zi light Aloxaf/fzf-tab

# # load this completions last -> https://wiki.zshell.dev/docs/guides/commands#calling-compinit-with-turbo-mode and https://wiki.zshell.dev/ecosystem/plugins/f-sy-h#-z-shellf-sy-h
# faster than zi light-mode for @zsh-users+fast TODO: start thread at https://github.com/orgs/z-shell/discussions/
# use ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20 according to https://github.com/zsh-users/zsh-autosuggestions.
# https://wiki.zshell.dev/docs/getting_started/overview#the-completion-management
# as'completion' blockf \
#   z-shell/zsh-fancy-completions \

# https://wiki.zshell.dev/docs/guides/syntax/for
zi wait lucid light-mode for \
  atinit'ZI[COMPINIT_OPTS]=-C; zicompinit_fast; zicdreplay; ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)' \
  zsh-users/zsh-syntax-highlighting \
  atload'!_zsh_autosuggest_start; ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20; ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"' \
  zsh-users/zsh-autosuggestions \
  blockf atpull'zi creinstall -q .' \
  zsh-users/zsh-completions

# only for git
# zstyle ':completion:*:*:git:*' fzf-search-display true
# or for everything
zstyle ':completion:*' fzf-search-display true
# don't use the old compctl completion system
zstyle ':completion:*' use-compctl false

# # fzf-tab
# # common options
# # disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# # set descriptions format to enable group support
# # NOTE: don't use escape sequences here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# # set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# zstyle ':completion:*' menu no
# # preview directory's content with eza when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# # switch group using `<` and `>`
# zstyle ':fzf-tab:*' switch-group '<' '>'

# fzf-tab completions from https://github.com/Aloxaf/fzf-tab/wiki/Preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --group-directories-first --color=always $realpath'
# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false
# use input as query string when completing zlua
zstyle ':fzf-tab:*' single-group ''
# preview git commands
# it is an example. you can change it
# zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
# 	'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
	'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
	'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
# zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
# 	'case "$group" in
# 	"modified file") git diff $word | delta ;;
# 	"recent commit object name") git show --color=always $word | delta ;;
# 	*) git log --color=always $word ;;
# 	esac'

zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'

export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

### OPTIONS
# https://www.viget.com/articles/zsh-config-productivity-plugins-for-mac-oss-default-shell/
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

unsetopt correct # don't correct command spelling
unsetopt flow_control # Disables the use of ⌃S to stop terminal output and the use of ⌃Q to resume it.

# Why would I want to exclude hidden files?
setopt glob_dots
# allow more sophisticated glob patterns
setopt extendedglob
# enable inline comments
setopt interactivecomments

# https://grml.org/zsh/zsh-lovers.html
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
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path $ZI[CACHE_DIR]
zstyle ':completion:*' rehash true
# Ignore completion for non-existant commands
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
# https://wiki.zshell.dev/docs/guides/customization#do-menu-driven-completion
# zstyle ':completion:*' menu select
# If you end up using a directory as argument, this will remove the trailing slash (useful in ln)
zstyle ':completion:*' squeeze-slashes true

# Smart case-y completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Dircolors on completions
# https://wiki.zshell.dev/docs/guides/customization#color-completion-for-some-things
# Zsh colors
if [[ "$CLICOLOR" != '0' ]]; then
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" 'ma=1;30;43'
fi

### bindings

# use vi keybindings
# C-j to enter vi mode
bindkey -v
# The time lapse between <Esc> and changing to insert mode.
export KEYTIMEOUT=1

# add custom bindings
bindkey ' '    magic-space
bindkey '\eK'  kill-line-to-system-clipboard
bindkey '\eY'  yank-from-system-clipboard
bindkey '\e^?' backward-kill-word
bindkey '\eb'  backward-word
bindkey '\ef'  forward-word
bindkey '\ek'  kill-line-to-system-clipboard
bindkey '\ey'  yank-from-system-clipboard
bindkey '^?'   backward-delete-char
bindkey '^A'   beginning-of-line
bindkey '^B'   backward-char
bindkey '^E'   end-of-line
bindkey '^F'   forward-char
bindkey '^G'   fzf-cd-widget
bindkey '^J'   vi-cmd-mode
bindkey '^K'   kill-line-to-x-selection
bindkey '^N'   down-history
bindkey '^P'   up-history
bindkey '^R'   history-incremental-search-backward
bindkey '^S'   history-incremental-search-forward
bindkey '^T'   fzf-file-widget
bindkey '^U'   kill-whole-line
bindkey '^W'   backward-kill-word
bindkey '^X'   fzf-history-widget
bindkey '^Y'   yank-from-x-selection
bindkey '^Z'   fzf-file-widget

bindkey "^H" autosuggest-execute

# full text editor editing of the command
autoload edit-command-line && zle -N edit-command-line
bindkey -M viins "^V" edit-command-line
bindkey -M vicmd "^V" edit-command-line

### alias
alias v="vim"
alias nv="nvim"
alias gs="gss"
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias _="sudo "
alias cdr='cd $(git rev-parse --show-toplevel)' # cd to git root

# ## add aliases for all recipes in ~/.user.justfile
# for recipe in `just --justfile ~/.user.justfile --summary 2> /dev/null`; do
#   alias $recipe="just --justfile ~/.user.justfile --working-directory . $recipe"
# done

# vim: ft=zsh sw=2 ts=2 et
