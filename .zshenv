# sourced on every invocation of zsh
# https://github.com/doronbehar/dotfiles/blob/master/.zshenv

# https://wiki.zshell.dev/docs/guides/customization#disabling-system-wide-compinit-call-ubuntu
if [[ ${OSTYPE} == linux* ]] && [[ -e /etc/debian_version ]]; then
  # Disable keyboard changes and compinit in /etc/zsh/zshrc.
  # zi takes care of this.
  DEBIAN_PREVENT_KEYBOARD_CHANGES=1
  skip_global_compinit=1
fi

# https://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/
export EDITOR="vim"
export MANPAGER="vim +MANPAGER -R --not-a-term -"
export MANWIDTH="100"
export VISUAL="$EDITOR"
export BLOCKSIZE="K" # show blocks as kilobytes
unset MAILCHECK # don't check for mails

export HISTORY_IGNORE="([bf]g|clear|exit|history|incognito|l|l[adfls]|pwd|x|\#*)"
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# ignore ones with a length greater than 80 -- thanks to https://github.com/Aloxaf
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='?(#c80,)'
# https://github.com/zsh-users/zsh-autosuggestions
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=242"

# pip
export PATH=$PATH:$HOME/.local/bin

# Treat these characters as part of a word.
[[ -n "$WORDCHARS" ]] || export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# vim: ft=zsh sw=2 ts=2 et
