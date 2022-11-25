if [[ -r "/home/sebastian/.config/zi/init.zsh" ]]; then
  source "/home/sebastian/.config/zi/init.zsh" && zzinit
fi

# environment variables
export EDITOR=vim

# export PATHs
export PATH=$PATH:/usr/local/go/bin

### annexes
zi light-mode for z-shell/z-a-meta-plugins @annexes @rust-utils

zi wait lucid for \
        OMZL::git.zsh \
  atload"unalias grv" \
        OMZP::git

zi light-mode for @sindresorhus/pure
zstyle :prompt:pure:git:stash show yes

zi wait lucid light-mode for \
  OMZP::fancy-ctrl-z \
  OMZP::nvm

zstyle ':omz:plugins:nvm' lazy true
zstyle ':omz:plugins:nvm' lazy-cmd nvim vim

zi ice wait'1' lucid
zi light laggardkernel/zsh-thefuck

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Has alias: "
zi wait lucid light-mode for @djui/alias-tips

### programs

## rust
## https://wiki.zshell.dev/ecosystem/annexes/rust
#Install rust and make it available globally in the system:
zi id-as"rust" wait=1 as=null sbin="bin/*" lucid rustup nocompile \
  atload="[[ ! -f ${ZI[COMPLETIONS_DIR]}/_cargo ]] && zi creinstall -q rust; \
  export CARGO_HOME=\$PWD; export RUSTUP_HOME=\$PWD/rustup" for \
    z-shell/0

zi lucid wait light-mode as"program" from"gh-r" for \
    atclone"cp -vf bat/autocomplete/bat.zsh _bat" \
    atpull"%atclone" \
    mv"bat* -> bat" pick"bat/bat" \
    @sharkdp/bat \

zi ice lucid wait from'gh-r' as'program' sbin'**/exa -> exa' atclone'cp -vf completions/exa.zsh _exa'
zi light ogham/exa
zi wait lucid for \
  has'exa' atinit'AUTOCD=1' \
    zplugin/zsh-exa

zi ice lucid wait as'program' has'bat' pick'src/*'
zi light eth-p/bat-extras

# Install the newest zsh
zi pack for zsh

# FZF
# Download the package with the bin-gem-node annex-utilizing ice list
# + setting up the key bindings. The "+keys" variants are available for each profile
zi pack"bgn+keys" for fzf

# The following example uses tree command to show the entries of the directory.
export FZF_ALT_C_OPTS="--preview 'exa -1 --icons --group-directories-first --color=always {} | head -200'"
# follow symbolic links and don't exclude hidden files
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source ~/fzf-git.sh/fzf-git.sh

# Install z.lua
# alternative: https://github.com/ajeetdsouza/zoxide
zi light-mode for @skywind3000/z.lua
eval "$(lua ~/.zi/plugins/skywind3000---z.lua/z.lua --init zsh enhanced once fzf)"

zi ice as'program' atclone'rm -f src/auto/config.cache; \ 
  ./configure --prefix=$ZPFX --enable-python3interp=yes' atpull'%atclone' make'all install' pick'$ZPFX/bin/vim'
  zi light vim/vim

# fzf-based tab-completion. Load after all other completion plugins
zi ice lucid wait has'fzf'
zi light Aloxaf/fzf-tab

### completions
zi ice lucid wait as'completion' blockf mv'git-completion.zsh -> _git'
zi snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh

zi ice as"completion"
zi snippet OMZP::docker/_docker

zi ice lucid wait as'completion' blockf has'rg'
zi snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

zi ice lucid wait as'completion' blockf has'alacritty'
zi snippet https://github.com/alacritty/alacritty/blob/master/extra/completions/_alacritty

zi ice lucid wait as'completion' blockf has'fd'
zi snippet OMZP::fd/_fd

zi ice lucid wait as'completion' blockf has'cargo'
zi snippet https://github.com/rust-lang/cargo/blob/master/src/etc/_cargo

zi ice lucid wait as'completion' blockf has'tldr' mv'zsh_tealdeer -> _tldr'
zi snippet https://github.com/dbrgn/tealdeer/blob/main/completion/zsh_tealdeer


# only for git
zstyle ':completion:*:*:git:*' fzf-search-display true
# or for everything
zstyle ':completion:*' fzf-search-display true

# fzf-tab completions from https://github.com/Aloxaf/fzf-tab/wiki/Preview
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --icons --group-directories-first --color=always $realpath'
# disable sort when completing options of any command
zstyle ':completion:complete:*:options' sort false
# use input as query string when completing zlua
zstyle ':fzf-tab:complete:_zlua:*' query-string input
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

# # load this completions last -> https://wiki.zshell.dev/docs/guides/commands#calling-compinit-with-turbo-mode
zi light-mode for \
  atinit"zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zi creinstall -q .' \
    zsh-users/zsh-completions

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

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' use-cache true
zstyle ':completion:*' rehash true

### bindings
# bindkey -v
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey "^E" autosuggest-execute

### alias
alias nv="nvim"
