# https://jdhao.github.io/2021/03/24/zsh_history_setup/
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
setopt promptsubst

unsetopt beep nomatch
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/semeyer/.zshrc'

fpath+=~/.zfunc

autoload -Uz compinit
compinit

# # End of lines added by compinstall
# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # this loads nvm bash completion

# .zshrc
autoload -U promptinit; promptinit

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit wait lucid for \
        OMZL::git.zsh \
  atload"unalias grv" \
        OMZP::git

zinit ice blockf
zinit light zsh-users/zsh-completions

# A glance at the new for-syntax – load all of the above
# plugins with a single command. For more information see:
# https://zdharma-continuum.github.io/zinit/wiki/For-Syntax/
zinit for \
    light-mode \
  zsh-users/zsh-autosuggestions \
    light-mode \
  zdharma-continuum/fast-syntax-highlighting \
  zdharma-continuum/history-search-multi-word \
    light-mode \
    pick"async.zsh" src"pure.zsh" \
  sindresorhus/pure

# Load after compinit, but before zsh-autosuggestions and zsh-syntax-highlighting (zsh-users+fast)
zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath' # remember to use single quote here!!!

# completion
zinit ice as"completion"
zinit snippet OMZP::docker/_docker

zinit ice as"completion"
zinit snippet OMZP::fd/_fd

### End of Zinit's installer chunk
# All of the above using the for-syntax and also z-a-bin-gem-node annex
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

# Install z.lua
zinit ice wait zinit light skywind3000/z.lua
eval "$(lua ~/.zinit/plugins/skywind3000---z.lua/z.lua --init zsh)"

# zsh-nvim
export NVM_LAZY_LOAD=true
# disable lazy load for vim command
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('vim')
zinit light "lukechilds/zsh-nvm"

zinit ice lucid wait as'completion' blockf has'rg'
zinit snippet https://github.com/BurntSushi/ripgrep/blob/master/complete/_rg

# FZF
# The following example uses tree command to show the entries of the directory.
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# follow symbolic links and don't exclude hidden files
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export PYTHONPATH=$PYTHONPATH:/home/sebastian/.local/lib/python3.8/site-packages
export PYTHONPATH=$PYTHONPATH:/home/sebastian/.local/bin

export PATH=$PATH:/snap/bin

bindkey '^k' autosuggest-execute

alias ll="exa --tree --level=2 -a --long"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fpath+=${ZDOTDIR:-~}/.zsh_functions

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
