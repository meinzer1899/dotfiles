# dotfiles
Linux dotfiles

## Remap CAPSLOCK to ctrl
https://askubuntu.com/questions/33774/how-do-i-remap-the-caps-lock-and-ctrl-keys#comment1154797_521734
sudo vi /etc/default/keyboard and change XKBOPTIONS="ctrl:nocaps"
setxkbmap -option ctrl:nocaps such that it

## lua
for zsh extension z.lua
https://www.lua.org/download.html -> Building (sudo make install)

## TMUX
https://github.com/tmux/tmux/wiki/Installing#from-version-control
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new -s tmux

## cargo
https://doc.rust-lang.org/cargo/getting-started/installation.html
https://rust-lang.github.io/rustup/installation/index.html #autocompletion

## fd
https://github.com/sharkdp/fd#installation

## rg
https://github.com/BurntSushi/ripgrep#installation
Clone repo, cd into repo, cargo install --path .

## zsh
https://github.com/zsh-users/zsh/blob/zsh-5.8.1/INSTALL (adapt version)
dont forget to checkout tagged commit

## fzf
https://github.com/junegunn/fzf

## vim
./configure --with-tlib=ncurses --enable-python3interp=yes
cd src && make && sudo make install
vim plug: https://github.com/junegunn/vim-plug

## node, nvm
https://github.com/nvm-sh/nvm#installing-and-updating

## ccls
https://github.com/MaskRay/ccls/wiki/Build
https://github.com/MaskRay/ccls/wiki/Install

## CMake language server
https://github.com/regen100/cmake-language-server

## Nerdfont
https://github.com/ronniedroid/getnf

## .gitconfig
[core]
    editor = vim
[diff]
    algorithm = histogram

## Ideas

### dotbare
Manage dotfiles and any git directories interactively with fzf
https://github.com/kazhala/dotbare

### mold
CC="clang" CXX="clang++" LDFLAGS="{LDFLAGS} -fuse-ld=mold" cmake ...

### nvim
Move to nvim and enable inlay type hints (with clangd-14)[https://clangd.llvm.org/extensions#inlay-hints)].
