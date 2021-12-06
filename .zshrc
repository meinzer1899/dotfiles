# Add installation directories for different platforms (e.g. pip, cargo)
export PATH=$PATH:/home/semeyer/.local/bin:/home/semeyer/.cargo/bin
# https://jdhao.github.io/2021/03/24/zsh_history_setup/
#
# the detailed meaning of the below three variable can be found in `man zshparam`.
export HISTFILE=~/.histfile
export HISTSIZE=1000000   # the number of items for the internal history list
export SAVEHIST=1000000   # maximum number of items for the history file

# The meaning of these options can be found in man page of `zshoptions`.
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

setopt autocd extendedglob notify
unsetopt beep nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/semeyer/.zshrc'

autoload -Uz compinit
compinit

# End of lines added by compinstall
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # this loads nvm bash completion

# .zshrc
autoload -U promptinit; promptinit

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node \
    zinit-zsh/z-a-meta-plugins

# Load after compinit, but before zsh-autosuggestions and zsh-syntax-highlighting (zsh-users+fast)
zinit light Aloxaf/fzf-tab

### End of Zinit's installer chunk
zinit for annexes zsh-users+fast
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure
zinit light skywind3000/z.lua

zinit lucid wait light-mode as"program" from"gh-r" for \
    atclone"cp -vf bat/autocomplete/bat.zsh _bat" \
    atpull"%atclone" \
    mv"bat* -> bat" pick"bat/bat" \
    @sharkdp/bat \
    \
    atclone"cp -vf completions/exa.zsh _exa" \
    atpull"%atclone" \
    mv"bin/exa* -> exa" \
    @ogham/exa

eval "$(lua ~/.zinit/plugins/skywind3000---z.lua/z.lua --init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
