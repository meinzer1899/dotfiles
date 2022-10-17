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

## zi
https://wiki.zshell.dev/docs/getting_started/installation

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
https://github.com/junegunn/fzf-git.sh

## vim
Important infos about editing .vimrc: https://vi.stackexchange.com/a/7723/30978

### vim plug
Gets installed automatically, see .vimrc.
vim plug: https://github.com/junegunn/vim-plug

### Installation via zi
should be installed automatically via zi.

### Manual Installation
./configure --with-tlib=ncurses --enable-python3interp=yes
cd src && make && sudo make install

### linter
https://github.com/iamcco/diagnostic-languageserver/wiki/Linters

#### shellcheck
https://github.com/koalaman/shellcheck#installing

#### vint
VimL linter
https://github.com/Vimjas/vint

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

## tldr
https://github.com/dbrgn/tealdeer and corresponding zsh completion plugin

## Ideas

### asynctask
https://github.com/skywind3000/asynctasks.vim
https://github.com/voldikss/vim-floaterm#asynctasksvim--asyncrunvim
https://github.com/voldikss/coc-extensions/tree/main/packages/coc-tasks

### dotbare
Manage dotfiles and any git directories interactively with fzf
https://github.com/kazhala/dotbare

### mold
CC="clang" CXX="clang++" LDFLAGS="{LDFLAGS} -fuse-ld=mold" cmake ...

### nvim
https://toroid.org/modern-neovim
https://github.com/AstroNvim/AstroNvim
https://github.com/artart222/CodeArt
https://github.com/p00f/clangd_extensions.nvim
https://github.com/shaun-mathew/Chameleon.nvim
https://github.com/phaazon/hop.nvim
https://github.com/lukas-reineke/indent-blankline.nvim
https://github.com/RRethy/nvim-base16
https://github.com/chriskempson/base16-shell
https://github.com/yamatsum/nvim-nonicons
Move to nvim and enable inlay type hints (with clangd-14)[https://clangd.llvm.org/extensions#inlay-hints)] => use ubuntu 22.04
https://codevion.github.io/#!vim/cpp2.md: (Neo)vim for C++ Part 2: CMake, GTest, File Explorer, etc
https://github.com/ibhagwan/fzf-lua
https://github.com/deathmaz/fzf-lua-asynctasks
