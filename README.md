# dotfiles

My Linux dotfiles.

![Work Environment](image/linux_environment.png "Linux Work Environment")

## Remap CAPSLOCK to ctrl

https://askubuntu.com/questions/33774/how-do-i-remap-the-caps-lock-and-ctrl-keys#comment1154797_521734
sudo vi /etc/default/keyboard and change XKBOPTIONS="ctrl:nocaps"
setxkbmap -option ctrl:nocaps such that it

## git

add .gitconfig.local for user entries

## TMUX

https://github.com/tmux/tmux/wiki/Installing#from-version-control
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux new -s tmux

## zi

https://wiki.zshell.dev/docs/getting_started/installation

zshrc's
https://git.sr.ht/~seirdy/dotfiles/tree/master/.config/shell_common/zsh/zinit.zsh
https://github.com/callistachang/dots/blob/main/dot_zshrc


## cargo and rust

Gets installed by zi.

https://doc.rust-lang.org/cargo/getting-started/installation.html
https://rust-lang.github.io/rustup/installation/index.html #autocompletion

Search rust book via cli:

https://github.com/0xhiro/thebook

## tealdeer

`cargo install tealdeer`

## fd

Gets installed by zi.
https://github.com/sharkdp/fd#installation

## rg

https://github.com/BurntSushi/ripgrep#installation

Gets installed by zi.

Currently, I use a local installation, because the last ripgrep relase is from
Jun 12, 2021.

Clone repo, cd into repo, 
cargo build --release --features 'pcre2' (pcre2 needed by anyjump.vim).
cargo install --path .
sudo cp $(which rg) /usr/local/bin/

## zsh

Gets installed by zi.

If, on a fresh system, zi cannot install zsh (because zsh is not available), try
to install zsh in a location, where no sudo privileges are needed (local?)
https://github.com/zsh-users/zsh/blob/zsh-5.8.1/INSTALL (adapt version)
dont forget to checkout tagged commit

## fzf

For FZF-TMUX to find fzf executable, change
`fzf="$(command -v fzf 2> /dev/null)" || fzf=$HOME/.zi/polaris/bin/fzf`

Gets installed by zi

https://github.com/junegunn/fzf

This gets not installed by zi: https://github.com/junegunn/fzf-git.sh

Vim Integration: https://github.com/junegunn/fzf/blob/master/README-VIM.md

## docker

completion gets installed automatically by zi
https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

## vim

https://bluz71.github.io/2021/09/10/vim-tips-revisited.html

Gets installed by zi.
Important infos about editing .vimrc: https://vi.stackexchange.com/a/7723/30978

### devcontainer

Login to dev container via ssh; install zsh and copy dotfiles
https://github.com/dpetersen/dev-container-base

https://gitlab.com/smoores/open-devcontainer
https://stackoverflow.com/questions/72397020/containerizing-vim-with-plugins
https://github.com/nemanjan00/dev-environment
https://github.com/esensar/nvim-dev-container

### vim plug

Gets installed automatically, see .vimrc.
vim plug: https://github.com/junegunn/vim-plug

### linter

https://github.com/caramelomartins/awesome-linters

https://github.com/iamcco/diagnostic-languageserver/wiki/Linters
All of them are configured via coc-diagnostic. Activate them by mapping the
linter to the desired filetype in `coc-settings.json`.
https://github.com/iamcco/coc-diagnostic/blob/master/src/config.ts

#### bash-language-server

`volta install bash-language-server`

#### vint

VimL linter
https://github.com/Vimjas/vint

#### hadolint (Dockerfile linter)

https://github.com/hadolint/hadolint
* tip: download release binary, cp to /usr/bin
* vim filetype for Dockerfiles is `dockerfiles`
* TODO: download & update via zi

## ccls

https://github.com/MaskRay/ccls/wiki/Build
https://github.com/MaskRay/ccls/wiki/Install

## CMake

### cmake4vim
https://github.com/ilyachur/cmake4vim/

### language server
https://github.com/regen100/cmake-language-server

## llvm, include-what-you-use

https://stackoverflow.com/questions/51582604/how-to-use-cpplint-code-style-checking-with-cmake

https://llvm.org/docs/CMake.html
https://github.com/include-what-you-use/include-what-you-use#how-to-build-as-part-of-llvm

`llvm-project/build$ cmake -G "Unix Makefiles" -DLLVM_ENABLE_PROJECTS=clang -DLLVM_EXTERNAL_PROJECTS=iwyu -DLLVM_EXTERNAL_IWYU_SOURCE_DIR=/path/to/iwyu ../llvm`

`llvm-project/build$ sudo cmake --build . --target install`

- [ ] update .vimrc with comments from https://github.com/nvim-zh/minimal_vim/blob/master/init.vim
- [ ] Read series https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character

## asynctask

https://github.com/skywind3000/asynctasks.vim
https://github.com/albertomontesg/lightline-asyncrun
https://github.com/deathmaz/fzf-lua-asynctasks (neovim)
https://github.com/voldikss/vim-floaterm#asynctasksvim--asyncrunvim
https://github.com/voldikss/coc-extensions/tree/main/packages/coc-tasks
https://github.com/EthanJWright/vs-tasks.nvim

## dotfiles management

- Manage dotfiles and any git directories interactively with fzf https://github.com/kazhala/dotbare
- https://dotfiles.github.io/

## mold

CC="clang" CXX="clang++" LDFLAGS="{LDFLAGS} -fuse-ld=mold" cmake ...

## nvim

https://www.youtube.com/watch?v=stqUbv-5u2s TJ De Vries  Effective Neovim: Instant IDE
https://github.com/nvim-lua/kickstart.nvim

lazy nvim
https://github.com/thieung/nvim

AstroNvim
https://github.com/AstroNvim/AstroNvim
https://astronvim.com/Recipes/advanced_lsp

https://github.com/askfiy/nvim

https://github.com/kutsan/dotfiles/blob/master/.config/nvim/plugin/settings.lua
https://github.com/nicknisi/dotfiles
https://github.com/disrupted/dotfiles/tree/master/.config/nvim
https://github.com/danymat/champagne
https://toroid.org/modern-neovim
https://github.com/joshukraine/dotfiles/tree/master/nvim

https://nvchad.com/
https://github.com/artart222/CodeArt
https://github.com/p00f/clangd_extensions.nvim
https://github.com/shaun-mathew/Chameleon.nvim
https://github.com/phaazon/hop.nvim
https://github.com/lukas-reineke/indent-blankline.nvim
https://github.com/RRethy/nvim-base16
https://github.com/chriskempson/base16-shell
https://github.com/yamatsum/nvim-nonicons
https://codevion.github.io/#!vim/cpp2.md: (Neo)vim for C++ Part 2: CMake, GTest, File Explorer, etc
https://github.com/ibhagwan/fzf-lua
https://github.com/deathmaz/fzf-lua-asynctasks
https://github.com/ggandor/leap.nvim vim sneak alternative
https://github.com/aserowy/tmux.nvim
https://gitlab.com/ivan-cukic/nvim-telescope-zeal-cli
https://github.com/jedrzejboczar/toggletasks.nvim
https://github.com/sindrets/diffview.nvim

### other

https://github.com/tummychow/git-absorb

https://github.com/jarun/ddgr with
https://github.com/tats/w3m/blob/master/doc/README

### offline documentation

https://zealdocs.org/
https://cukic.co/2022/04/02/fuzzy-search-documentation/
https://gitlab.com/ivan-cukic/zeal-lynx-cli
