# https://github.com/doronbehar/dotfiles/blob/master/.zshenv

# https://wiki.zshell.dev/docs/guides/customization#disabling-system-wide-compinit-call-ubuntu
skip_global_compinit=1

# https://zameermanji.com/blog/2012/12/30/using-vim-as-manpager/
export EDITOR="vim"
export MANPAGER="vim +MANPAGER -R --not-a-term -"
export MANWIDTH="100"
export VISUAL="$EDITOR"
export BLOCKSIZE="K" # show blocks as kilobytes
unset MAILCHECK # don't check for mails

# (exit|ls|pkill)
export HISTORY_IGNORE="(exit)"
