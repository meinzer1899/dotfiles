# dotfiles

Linux dotfiles

## Remap CAPSLOCK to ctrl

https://askubuntu.com/questions/33774/how-do-i-remap-the-caps-lock-and-ctrl-keys#comment1154797_521734
sudo vi /etc/default/keyboard and change XKBOPTIONS="ctrl:nocaps"
setxkbmap -option ctrl:nocaps such that it

## lua

not needed if zoxide is used in .zshrc
for zsh extension z.lua
https://www.lua.org/download.html -> Building (sudo make install)

## TMUX

https://github.com/tmux/tmux/wiki/Installing#from-version-control
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new -s tmux

## zi

https://wiki.zshell.dev/docs/getting_started/installation

## cargo and rust

Gets installed by zi.

https://doc.rust-lang.org/cargo/getting-started/installation.html
https://rust-lang.github.io/rustup/installation/index.html #autocompletion

Search rust book via cli:

https://github.com/0xhiro/thebook

## fd

Gets installed by zi.
https://github.com/sharkdp/fd#installation

## rg

Gets installed by zi.
https://github.com/BurntSushi/ripgrep#installation
Clone repo, cd into repo, cargo install --path .

## zsh

Gets installed by zi.
https://github.com/zsh-users/zsh/blob/zsh-5.8.1/INSTALL (adapt version)
dont forget to checkout tagged commit

## fzf

Gets installed by zi.
https://github.com/junegunn/fzf
This gets not installed by zi.
https://github.com/junegunn/fzf-git.sh

## vim

Gets installed by zi.
Important infos about editing .vimrc: https://vi.stackexchange.com/a/7723/30978

### vim plug

Gets installed automatically, see .vimrc.
vim plug: https://github.com/junegunn/vim-plug

### linter

https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
All of them are configured via coc-diagnostic. Activate them by mapping the
linter to the desired filetype in `coc-settings.json`.

#### bash-language-server

`volta install bash-language-server`

#### shellcheck

https://github.com/koalaman/shellcheck#installing

#### vint

VimL linter
https://github.com/Vimjas/vint

#### hadolint (Dockerfiles)

https://github.com/hadolint/hadolint
* tip: download release binary, cp to /usr/bin
* vim filetype for Dockerfiles is `dockerfiles`
* TODO: download & update via zi

## node, nvm

https://github.com/nvm-sh/nvm#installing-and-updating

## ccls

https://github.com/MaskRay/ccls/wiki/Build
https://github.com/MaskRay/ccls/wiki/Install

## CMake language server

https://github.com/regen100/cmake-language-server

## llvm, include-what-you-use

https://stackoverflow.com/questions/51582604/how-to-use-cpplint-code-style-checking-with-cmake

https://llvm.org/docs/CMake.html
https://github.com/include-what-you-use/include-what-you-use#how-to-build-as-part-of-llvm

`llvm-project/build$ cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS=clang -DLLVM_EXTERNAL_PROJECTS=iwyu -DLLVM_EXTERNAL_IWYU_SOURCE_DIR=/path/to/iwyu ../llvm`

`llvm-project/build$ sudo cmake --build . --target install`

- [ ] update .vimrc with comments from https://github.com/nvim-zh/minimal_vim/blob/master/init.vim
- [ ] Read series https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character

### asynctask

https://github.com/skywind3000/asynctasks.vim
https://github.com/albertomontesg/lightline-asyncrun
https://github.com/deathmaz/fzf-lua-asynctasks (neovim)
https://github.com/voldikss/vim-floaterm#asynctasksvim--asyncrunvim
https://github.com/voldikss/coc-extensions/tree/main/packages/coc-tasks

### dotfiles management

- Manage dotfiles and any git directories interactively with fzf https://github.com/kazhala/dotbare
- https://dotfiles.github.io/

### mold

CC="clang" CXX="clang++" LDFLAGS="{LDFLAGS} -fuse-ld=mold" cmake ...

### nvim

https://toroid.org/modern-neovim
https://github.com/AstroNvim/AstroNvim
https://nvchad.com/
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
https://github.com/ggandor/leap.nvim vim sneak alternative
