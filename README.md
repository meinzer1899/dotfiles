# dotfiles

My Linux dotfiles.

![Work Environment](image/linux_environment.png "Linux Work Environment")

# Setup new machine

1. Install git
2. Install stow

## Remap CAPSLOCK to ctrl

https://askubuntu.com/questions/33774/how-do-i-remap-the-caps-lock-and-ctrl-keys#comment1154797_521734
sudo vi /etc/default/keyboard and change XKBOPTIONS="ctrl:nocaps"
setxkbmap -option ctrl:nocaps such that it

## VirtualBox

Update GuestAdditions after updating VirtualBox via https://help.ubuntu.com/community/VirtualBox/GuestAdditions.
```bash
sudo apt-get install virtualbox-guest-additions-iso
```

## git

https://github.com/mathiasbynens/dotfiles/blob/main/.gitconfig

For Ubuntu, this PPA provides the latest stable upstream Git version: https://git-scm.com/download/linux.

Add .gitconfig.local for user entries
Change local user.email (optionally also user.name) in this repository, so that Github
can associate commit with user.

https://github.com/bigH/git-fuzzy
https://github.com/gitleaks/gitleaks

## TMUX

https://github.com/tmux/tmux/wiki/Installing#from-version-control

```bash
sh autogen.sh
./configure
make -j$(nproc) && sudo make install
```
tmux new -s tmux

## zi

https://wiki.zshell.dev/docs/getting_started/installation


## cargo and rust

Gets installed by zi.

https://doc.rust-lang.org/cargo/getting-started/installation.html
https://rust-lang.github.io/rustup/installation/index.html #autocompletion

Search rust book via cli:

https://github.com/0xhiro/thebook

## zsh

Gets installed by zi.

On a fresh system, zi cannot install zsh (because zsh is not available), try
to install zsh in a location, where no sudo privileges are needed (local?)
https://github.com/zsh-users/zsh/blob/zsh-5.8.1/INSTALL (adapt version)
don't forget to checkout tagged commit.

zshrcs
https://github.com/Freed-Wu/Freed-Wu/blob/main/.zshrc
https://github.com/kutsan/dotfiles/blob/master/.config/zsh/config/settings.zsh
https://git.sr.ht/~seirdy/dotfiles/tree/master/.config/shell_common/zsh/zinit.zsh
https://github.com/callistachang/dots/blob/main/dot_zshrc
https://github.com/casey/dotfiles/blob/master/etc/zshrc
https://github.com/agkozak/
https://github.com/seagle0128/dotfiles/blob/master/.zshrc

plugins
https://github.com/Freed-Wu/fzf-tab-source

## fzf

Adapt tmux-fzf to find fzf:
```bash
- fzf="$(command -v fzf 2> /dev/null)" || fzf="$(dirname "$0")/fzf"
+ fzf="$(command -v fzf 2> /dev/null)" || fzf=$HOME/.zi/polaris/bin/fzf
```

To auto-accept entry on Enter when searching with CTRL-R, use
https://github.com/junegunn/fzf/issues/477#issuecomment-444053054

Gets installed by zi

https://github.com/junegunn/fzf

This gets not installed by zi: https://github.com/junegunn/fzf-git.sh

Vim Integration: https://github.com/junegunn/fzf/blob/master/README-VIM.md

## docker

completion gets installed automatically by zi
https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

## vim

https://github.com/skywind3000/vim/blob/master/init/unix.vim
https://github.com/trapd00r/configs/blob/master/vim/vimrc
https://github.com/suy/configs/blob/master/vimrc
https://github.com/rhysd/dogfiles/blob/master/vimrc
https://github.com/fannheyward/init.vim/blob/master/coc-settings.json
https://github.com/fannheyward/init.vim/blob/master/init.vim

https://bluz71.github.io/2021/09/10/vim-tips-revisited.html
https://vimtricks.com/p/category/tips-and-tricks/
http://vimcasts.org/episodes/search-multiple-files-with-vimgrep/
https://github.com/yuki-yano/fzf-preview.vim

Gets installed by zi.
Important infos about editing .vimrc: https://vi.stackexchange.com/a/7723/30978

### devcontainer

https://www.docker.com/blog/how-to-setup-your-local-node-js-development-environment-using-docker/
https://stackoverflow.com/questions/51809181/how-to-run-tmux-inside-a-docker-container
https://wiki.zshell.dev/ecosystem/packages/usage#statically-linked-hermetic-relocatable-zsh

Login to dev container via ssh; install zsh and copy dotfiles
https://github.com/dpetersen/dev-container-base

https://gitlab.com/smoores/open-devcontainer
https://stackoverflow.com/questions/72397020/containerizing-vim-with-plugins
https://github.com/nemanjan00/dev-environment
https://github.com/esensar/nvim-dev-container

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

## C++

### ccls

https://github.com/MaskRay/ccls/wiki/Build
https://github.com/MaskRay/ccls/wiki/Install

### CMake

Installed via zi.

https://github.com/foonathan/docker/blob/a18a54c3f04df077419fc21853e219375b2bb58a/common/install-cmake.sh

#### misc

[cmake4vim](https://github.com/ilyachur/cmake4vim/)
[cmake-language-server](https://github.com/regen100/cmake-language-server)

Determine the minimal required CMake version of a project: [cmake_min_version](https://github.com/nlohmann/cmake_min_version)

### llvm, clang

https://github.com/google/sanitizers/wiki/AddressSanitizerFlags
https://github.com/google/sanitizers/wiki/AddressSanitizerFlags
```cmake
message(STATUS "Address sanitizer enabled")
add_compile_options(-fsanitize=address,undefined)
add_compile_options(-fno-sanitize=signed-integer-overflow)
add_compile_options(-fno-sanitize-recover=all)
add_compile_options(-fno-omit-frame-pointer)
add_link_options(-fsanitize=address,undefined -fuse-ld=gold)
```

Installation description:
https://apt.llvm.org/ -> Automatic installation script
installs *all* llvm packages (also clangd, clang-tidy, include-cleaner etc) at `/bin`.
Also adds apt.llvm.org to apt package list to automatically get updates.

```bash
sudo update-alternatives --install /bin/clang-format clang-format /bin/clang-format-17 20
```

Cache for clang-tidy static analysis results:
https://github.com/matus-chochlik/ctcache/tree/main

https://stackoverflow.com/questions/51582604/how-to-use-cpplint-code-style-checking-with-cmake

https://github.com/lmapii/run-clang-tidy

https://llvm.org/docs/GettingStarted.html#getting-the-source-code-and-building-llvm

- [ ] update .vimrc with comments from https://github.com/nvim-zh/minimal_vim/blob/master/init.vim
- [ ] Read series https://jdhao.github.io/2019/03/28/nifty_nvim_techniques_s1/#how-do-we-select-the-current-line-but-not-including-the-newline-character

### docker
https://github.com/think-cell/docker

## asynctask

https://github.com/skywind3000/asynctasks.vim
https://github.com/albertomontesg/lightline-asyncrun
https://github.com/deathmaz/fzf-lua-asynctasks (neovim)
https://github.com/voldikss/vim-floaterm#asynctasksvim--asyncrunvim
https://github.com/skywind3000/vim-terminal-help#integration
https://github.com/voldikss/coc-extensions/tree/main/packages/coc-tasks
https://github.com/EthanJWright/vs-tasks.nvim

## dotfiles management

- Manage dotfiles and any git directories interactively with fzf https://github.com/kazhala/dotbare
- https://dotfiles.github.io/
- https://github.com/rhysd/dotfiles

## mold

CC="clang" CXX="clang++" LDFLAGS="{LDFLAGS} -fuse-ld=mold" cmake ...

## neovim

Neovim for C++: https://www.youtube.com/watch?v=lsFoZIg-oDs

Use FZF instead of telescope
https://github.com/ibhagwan/fzf-lua#why-fzf-lua
https://github.com/ibhagwan/nvim-lua

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

https://hackingcpp.com/dev/command_line_tools.html

https://github.com/tummychow/git-absorb

https://github.com/jarun/ddgr with
https://github.com/tats/w3m/blob/master/doc/README

Whiteboards with https://tldraw.dev/.
https://github.com/casey/just
https://github.com/NoahTheDuke/vim-just (Plug 'NoahTheDuke/vim-just', { 'for':
'just' })

### offline documentation

https://zealdocs.org/
https://cukic.co/2022/04/02/fuzzy-search-documentation/
https://gitlab.com/ivan-cukic/zeal-lynx-cli
