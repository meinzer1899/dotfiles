# dotfiles

My Linux dotfiles.

```bash
▶ zsh-bench
==> benchmarking login shell of user meinzer1899...
creates_tty=0
has_compsys=0
has_syntax_highlighting=0
has_autosuggestions=0
has_git_prompt=0
first_prompt_lag_ms=26.536
first_command_lag_ms=115.626
command_lag_ms=2.363
input_lag_ms=4.038
exit_time_ms=101.818
```

Is this fast? From https://github.com/romkatv/zsh-bench#how-fast-is-fast

| latency (ms)          | the maximum value indistinguishable from zero |
|-----------------------|----------------------------------------------:|
| **first prompt lag**  |                                            50 |
| **first command lag** |                                           150 |
| **command lag**       |                                            10 |
| **input lag**         |                                            20 |

Although showing `0` for `has_syntax_highlighting`, `has_git_prompt`, `has_autosuggestions`, `has_compsys`,
these are enabled.

![Work Environment](image/linux_environment.png "Linux Work Environment")

# Setup new machine

1. Install git and pull dotfiles repository
1. Setup WSL
1. `mkdir -p $HOME/.config` (otherwise, `.config` is a symlink to `$HOME/dotfiles/.config`).
1. Install zsh and zi
1. Install stow, run `cd dotfiles && stow .`
1. Install tmux

## pip

* difference `python pip install` vs `python -m pip install` https://stackoverflow.com/questions/25749621/whats-the-difference-between-pip-install-and-python-m-pip-install
* https://thelinuxcode.com/python-requirements-txt-file/

```bash
apt install python3.XX-venv # (e.g. 10)
```

Don't upgrade system to use other python version than that available in apt. Can cause other commands
(e.g. apt-get) to break.

## clipboard

```bash
apt install xclip
```

## Remap CAPSLOCK to ctrl

https://askubuntu.com/questions/33774/how-do-i-remap-the-caps-lock-and-ctrl-keys#comment1154797_521734
sudo vi /etc/default/keyboard and change XKBOPTIONS="ctrl:nocaps"
setxkbmap -option ctrl:nocaps

https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10

## VirtualBox

Update GuestAdditions after updating VirtualBox via https://help.ubuntu.com/community/VirtualBox/GuestAdditions.
```bash
sudo apt-get install virtualbox-guest-additions-iso
```

## wsl

* Install nerd font
    * on Linux via curl https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#option-1-release-archive-download.
    * on Windows via downloading zip archive and using Settings -> fonts (move font files into dotted square)
* Install alacritty for Windows.
* Move alacritty.wsl.toml to [`%APPDATA%\alacritty`](https://github.com/alacritty/alacritty?tab=readme-ov-file#configuration).
* map capslock to ctrl: https://superuser.com/questions/949385/map-capslock-to-control-in-windows-10.
* Alternatively, use [MS PowerToys](https://learn.microsoft.com/en-us/windows/powertoys/install#installing-with-microsoft-store) to map Ctrl-M as Enter as well. Cannot map Ctrl-J to down (Ctrl-K up, Ctrl-C Esc) because that conflicts with either Linux or Windows shortcuts. In MS PowerToys dashboard, deactivate all other modules that are not needed.
* notifications: https://github.com/Windos/BurntToast, call with       `notify-send() { powershell.exe -command New-BurntToastNotification "-Text '${@}'"; }`. Further reading https://stuartleeks.com/posts/wsl-github-cli-windows-notifications-part-1/ and https://github.com/microsoft/WSL/issues/2466.
* Kill WSL2 (e.g. does not respond): https://github.com/microsoft/WSL/issues/6982#issuecomment-1474994319
* Configuration: https://learn.microsoft.com/en-us/windows/wsl/wsl-config#user-settings

## zsh and zi

https://github.com/zsh-users/zsh/blob/master/INSTALL

`$ZPFX`: https://wiki.zshell.dev/docs/guides/customization#ZPFX

Install zsh to $HOME/.zi/polaris, where no sudo is needed.

```bash
mkdir -p $HOME/.zi/polaris
./configure --prefix=$HOME/.zi/polaris
```

zi loader is included in dotfiles (.config/zi)
Additional information https://wiki.zshell.dev/docs/getting_started/installation => loader.
Don't use other installation methods using curl, because of security issues (https://github.com/z-shell/wiki/issues/588).

### misc

* https://registerspill.thorstenball.com/p/how-fast-is-your-shell
* https://github.com/unixorn/awesome-zsh-plugins

### zshrcs

* https://github.com/bew/dotfiles/tree/main/zsh
* https://github.com/HaleTom/dotfiles/blob/main/zsh/.config/zsh/.zshrc
* https://github.com/mattmc3/zdotdir
* https://github.com/doronbehar/dotfiles/blob/master/.zshrc
* https://github.com/ctrueden/dotfiles/blob/main/zshrc
* https://github.com/itchyny/dotfiles/blob/main/.zshrc
* https://github.com/timtyrrell/dotfiles-chezmoi/blob/master/dot_zshrc
* https://github.com/Freed-Wu/Freed-Wu/blob/main/.zshrc
* https://github.com/kutsan/dotfiles/blob/master/.config/zsh/config/settings.zsh
* https://git.sr.ht/~seirdy/dotfiles/tree/master/.config/shell_common/zsh/zinit.zsh
* https://github.com/callistachang/dots/blob/main/dot_zshrc
* https://github.com/casey/dotfiles/blob/master/etc/zshrc
* https://github.com/agkozak/
* https://github.com/seagle0128/dotfiles/blob/master/.zshrc

## bash

https://mywiki.wooledge.org/BashPitfalls
https://mywiki.wooledge.org/BashPitfalls#set_-euo_pipefail recommends against `set -e` because of the various pitfalls especially in conditional evaluation and option `pipefail` and recommends own error handling instead.
http://redsymbol.net/articles/unofficial-bash-strict-mode/
and http://redsymbol.net/articles/unofficial-bash-strict-mode/#short-circuiting
```bash
set -euo pipefail; shopt -s failglob # safe mode
```

To release resources, use bash exit traps. http://redsymbol.net/articles/bash-exit-traps/

* https://mywiki.wooledge.org/BashFAQ
* https://mywiki.wooledge.org/BashGuide
* https://mywiki.wooledge.org/BashPitfalls
* https://www.gnu.org/software/bash//manual/html_node/The-Shopt-Builtin.html
* https://quickref.me/bash
* https://devhints.io/bash

## git

* https://github.com/gitleaks/gitleaks Protect and discover secrets using Gitleaks 🔑
* https://github.com/stevearc/dotfiles/blob/master/.githelpers
* https://github.com/mathiasbynens/dotfiles/blob/main/.gitconfig

For Ubuntu, this PPA provides the latest stable upstream Git version: https://git-scm.com/download/linux.

Add .gitconfig.local for user private global entries
https://git-scm.com/docs/user-manual.html#telling-git-your-name

Add ssh key so that you can push to dotfiles repository with correct user.

In dotfiles repository, change local email to noreply email from Github (preferences, email)
https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-personal-account-on-github/managing-email-preferences/setting-your-commit-email-address#setting-your-email-address-for-a-single-repository

ssh keys:
~/.ssh/config
specify, which key belongs to which host
(https://stackoverflow.com/a/69764024)

[🦎 Githooks: per-repo and shared Git hooks with version control and auto update.](https://github.com/gabyx/Githooks)
[interactive `git` with the help of `fzf`      ](https://github.com/bigH/git-fuzzy)
[Protect and discover secrets using Gitleaks 🔑      ](https://github.com/gitleaks/gitleaks)
[Command-line Git information tool](https://github.com/o2sh/onefetch)

## alacritty

https://github.com/alacritty/alacritty/blob/master/INSTALL.md
```bash
cargo build --release
```

Windows: download executable

## TMUX

https://github.com/tmux/tmux/wiki/Installing#from-version-control

```bash
sh autogen.sh
./configure
make -j$(nproc) && sudo make install
```

`tmux new -s tmux`

.tmux.conf:
* https://github.com/sunaku/home/blob/master/.tmux.conf.erb
* https://github.com/doronbehar/.tmux/tree/master
* https://gist.github.com/adibhanna/979461c5f7d906daf24925fbd9b255eb
* https://github.com/mrnugget/dotfiles/blob/master/tmux.conf

## cargo and rust

Search rust book via cli:

https://github.com/0xhiro/thebook

## fzf

To auto-accept entry on Enter when searching with CTRL-R, use `fzf-accept-on-enter.diff`
from https://github.com/junegunn/fzf/issues/477#issuecomment-444053054.

`git apply --stat --apply ~/dotfiles/fzf-accept-on-enter.diff`
`mv fzf-keybindings-new.zsh fzf-key-bindings.zsh`

* https://github.com/junegunn/fzf
* https://github.com/junegunn/fzf-git.sh

Vim Integration: https://github.com/junegunn/fzf/blob/master/README-VIM.md

## docker

https://stackoverflow.com/questions/45023363/what-is-docker-io-in-relation-to-docker-ce-and-docker-ee-now-called-mirantis-k
https://docs.docker.com/engine/install/ubuntu

```bash
    docker run --detach -v $(pwd):$(pwd) -w $(pwd) --name <name> image:tag sleep infinity # may does not work, if ENTRYPOINT is set in Dockerfile
    docker start <name> # if container with that name already exists
    docker exec <name> command # execute command, e.g. via vim-dispatch
    docker exec -it <name> /bin/bash # attach interactively
    docker stop name # to stop
```

* https://devopscube.com/reduce-docker-image-size/

* https://github.com/wagoodman analyze image size, vulnerabilities and more
* https://github.com/kkvh/vim-docker-tools Toolkit for managing docker containers, networks and images in vim.

* https://github.com/lmapii/cproject Example for a C environment with CMake, Docker, Unity, and GitHub Actions.
* https://github.com/philips-software/amp-devcontainer/tree/main/.devcontainer/cpp
* https://github.com/StableCoder/docker-build-core
* https://github.com/think-cell/docker
* https://github.com/foonathan/docker/tree/main
* https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

## vim

* https://github.com/ibhagwan/vim-cheatsheet
* https://learnvimscriptthehardway.stevelosh.com/
* https://github.com/mattmc3/neovim-cheatsheet

* https://www.youtube.com/playlist?list=PLrU0uga7kmr0dsc3wWS4TS9mRX0Ue7kn Vim Universe Playlist
* https://swedishembedded.com/developers/vim-in-minutes Awesome Vim: Modern Guide To A Fully Featured Vim IDE
* https://bluz71.github.io/2021/09/10/vim-tips-revisited.html
* https://vimtricks.com/p/category/tips-and-tricks/
* http://vimcasts.org/episodes/search-multiple-files-with-vimgrep/
* https://github.com/yuki-yano/fzf-preview.vim

Important infos about editing .vimrc: https://vi.stackexchange.com/a/7723/30978

### vimrcs

* https://github.com/sunaku/.vim/tree/master
* https://github.com/mrnugget/vimconfig/tree/master
* https://github.com/itchyny/dotfiles/blob/main/.vimrc
* https://github.com/mischavandenburg/dotfiles/blob/main/vim/.vimrc
* https://github.com/doronbehar/.config_nvim/tree/master
* https://github.com/habamax/.vim/blob/master/vimrc (vim maintainer)
* https://github.com/mrnugget/vimconfig/blob/master/vimrc
* https://github.com/skywind3000/vim/blob/master/init/unix.vim
* https://github.com/trapd00r/configs/blob/master/vim/vimrc
* https://github.com/suy/configs/blob/master/vimrc
* https://github.com/rhysd/dogfiles/blob/master/vimrc
* https://github.com/fannheyward/init.vim/blob/master/coc-settings.json
* https://github.com/fannheyward/init.vim/blob/master/init.vim

### lua support

```bash
apt install luaX.X libluaX.X-dev luajit
./configure --enable-luainterp=yes
```

### devcontainer

* https://github.com/stepchowfun/toast Containerize your development and continuous integration environments. 🥂
* https://www.docker.com/blog/how-to-setup-your-local-node-js-development-environment-using-docker/
* https://stackoverflow.com/questions/51809181/how-to-run-tmux-inside-a-docker-container
* https://wiki.zshell.dev/ecosystem/packages/usage#statically-linked-hermetic-relocatable-zsh

Login to dev container via ssh; install zsh and copy dotfiles
https://github.com/dpetersen/dev-container-base

* https://gitlab.com/smoores/open-devcontainer
* https://stackoverflow.com/questions/72397020/containerizing-vim-with-plugins
* https://github.com/nemanjan00/dev-environment
* https://github.com/esensar/nvim-dev-container

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

## C++ cpp

Compiler warnings

* https://best.openssf.org/Compiler-Hardening-Guides/Compiler-Options-Hardening-Guide-for-C-and-C++.html
* https://libcxx.llvm.org/Hardening.html
* https://clang.llvm.org/docs/DiagnosticsReference.html
* https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

* https://github.com/stephenberry/glaze Extremely fast, in memory, JSON and interface library for modern C++

* https://github.com/HappyCerberus/daily-bite-cpp (especially Modern-only C++ Course)
[Playlist: Modern C++ Series - Mike Shah](https://www.youtube.com/playlist?list=PLvv0ScY6vfd8j-tlhYVPYgiIyXduu6m-L)
* https://akrzemi1.wordpress.com/
* https://www.meetingcpp.com/blog/blogroll/

playground
[HU print chunks 0001'0203'...'0e0f](https://godbolt.org/z/98zvoc7Eb)

### ccls languageserver

* https://github.com/MaskRay/ccls/wiki/Build
* https://github.com/MaskRay/ccls/wiki/Install

### [googletest](https://google.github.io/googletest/)

Reduce execution times of unit tests:
* run CTest in parallel `ctest --parallel`
* use `gtest_discover_tests` (scans test executable) `gtest_add_tests` (scans source code for googletest macros) ( from https://cmake.org/cmake/help/latest/module/GoogleTest.html
* this executes a list of all _test cases_ instead of the whole _test executable_, which is much faster
* https://cmake.org/cmake/help/latest/manual/ctest.1.html
* e.g. `ctest --parallel --test-dir <build directory> -R <regex filter for tests> --rerun-failed --output-on-failure`

### CMake

Use install-cmake.sh from foonathan to install to /usr/local. May remove "old" cmake versions, check via `which -a cmake`.

https://blog.feabhas.com/category/build-systems/
with https://github.com/feabhas/cmake-presets-blog

* https://cmake.org/cmake/help/latest/module/CTestCoverageCollectGCOV.html
* https://crascit.com/category/cmake/
* https://fekir.info/post/conditional-compilation/
* https://fekir.info/post/dependency-injection-in-cmake/
* https://github.com/madduci/moderncpp-project-template A Modern C++ cross-platform Project Template with CMake, conan (optional), cppcheck (optional) and clang-format (optional)
* https://github.com/filipdutescu/modern-cpp-template A template for modern C++ projects using CMake, Clang-Format, CI, unit testing and more, with support for downstream inclusion.
* https://github.com/TheLartians/Format.cmake Stylize your code! Automatic clang-format and cmake-format targets for CMake.
* https://github.com/intel/cicd-repo-infrastructure
* https://github.com/StableCoder/cmake-scripts
* https://github.com/cpp-best-practices/cmake_template

#### Misc

* [Macros usages in C++](https://fekir.info/post/macro-usages-in-cpp/)

[cmake4vim](https://github.com/ilyachur/cmake4vim/)
[cmake-language-server](https://github.com/regen100/cmake-language-server)

Determine the minimal required CMake version of a project: [cmake_min_version](https://github.com/nlohmann/cmake_min_version)

### Online Compiler

* https://build-bench.com/
* https://godbolt.org/
* https://cppinsights.io/
* https://www.perfbench.com/
* https://quick-bench.com/

### Optimization, performance, profiling, dependencies

* https://github.com/springmeyer/profiling-guide with perf(linux)
* https://github.com/jmuehlig/perf-cpp
* https://fekir.info/post/cpp-performance-guidelines/
* https://fekir.info/post/library-dependency-graphs-in-cmake/
* https://vitaut.net/posts/2024/faster-cpp-compile-times/
* https://fekir.info/post/analyze-build-times-with-clang/
* https://fekir.info/post/analyze-configure-times-with-cmake/

### _LLVM_, `clang`, `clangd`

* https://clang.llvm.org/docs/UndefinedBehaviorSanitizer.html
* https://github.com/google/sanitizers/wiki/AddressSanitizerFlags
```cmake
message(STATUS "Address sanitizer enabled")
add_compile_options(-fsanitize=address,undefined,integer)
add_compile_options(-fsanitize=unsigned-integer-overflow)
add_compile_options(-fno-sanitize=signed-integer-overflow)
add_compile_options(-fno-sanitize-recover=all)
add_compile_options(-fno-omit-frame-pointer)
add_compile_options(-fsanitize-trap=undefined) # stop (TRAP signal) after first occurrence
add_link_options(-fsanitize=address,undefined)
add_link_options(-fuse-ld=clang++) # according to UB san documentation for clang
```

Installation description:
https://apt.llvm.org/ -> Automatic installation script
installs *all* llvm packages (also clangd, clang-tidy, include-cleaner etc) at `/bin`.
Also adds apt.llvm.org to apt package list to automatically get updates.
CAUTION:
if there is a major version update, this gets not added automatically, because the script above adds
only specified major version to apt list, e.g. https://apt.llvm.org/jammy llvm-toolchain-jammy-18 InRelease.
For me using Ubuntu 22.04, I called the script again, but it installed 18, not newest 19.
Section:
```bash
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh <version number> all
```
needed to also install clang-tidy etc.

Need to update alternatives for llvm tools, e.g. clang-format, clangd, clang-tidy, lld.
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

### GDB

https://sourceware.org/gdb/current/onlinedocs/gdb.html/index.html
```vim
:packadd termdebug
:Termdebug " help Termdebug, :Arguments <args, eg. --gtest_filter=<unquoted regex>
```

* https://jotavare.github.io/gdb_cheatsheet/
* https://github.com/sharkdp/dbg-macro A dbg(…) macro for C++
* Replace .gdbinit with https://github.com/pwndbg/pwndbg Exploit Development and Reverse Engineering with GDB Made Easy
* https://developers.redhat.com/articles/2021/10/05/printf-style-debugging-using-gdb-part-1#
* https://developers.redhat.com/articles/2021/10/13/printf-style-debugging-using-gdb-part-2#

## asynctask

* https://github.com/mg979/tasks.vim rewrite of asynctasks
* https://github.com/skywind3000/asynctasks.vim
* https://github.com/albertomontesg/lightline-asyncrun
* https://github.com/deathmaz/fzf-lua-asynctasks (neovim)
* https://github.com/voldikss/vim-floaterm#asynctasksvim--asyncrunvim
* https://github.com/skywind3000/vim-terminal-help#integration
* https://github.com/voldikss/coc-extensions/tree/main/packages/coc-tasks
* https://github.com/EthanJWright/vs-tasks.nvim

## dotfiles management

* https://github.com/yous/dotfiles
* https://github.com/sunaku/home
* https://sunaku.github.io/about.html
* https://github.com/ibhagwan/dots
* https://github.com/hamvocke/dotfiles
* I use stow.
* Manage dotfiles and any git directories interactively with fzf https://github.com/kazhala/dotbare
* https://dotfiles.github.io/
* https://github.com/rhysd/dotfiles

## mold

```sh
CC="clang" CXX="clang++" LDFLAGS="{LDFLAGS} -fuse-ld=mold" cmake ...
```

## neovim nvim

[The Laziest Neovim (NeovimConf 2023) | Speed Up Neovim](https://www.youtube.com/watch?v=FMa3eURbgQ8)
[Neovim for Newbs. FREE COURSE](https://youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn&si=rAgKT6KALr0KLg-J)
[The Only Video You Need to Get Started with Neovim](https://youtube.com/watch?v=m8C0Cq9Uv9o&si=vBLbYpfQiMMLgm4d)
[The perfect Neovim setup for C++](https://youtube.com/watch?v=lsFoZIg-oDs&si=Ek-FGDD2BUq4zHJM)
[C++ Coding with Neovim - Prateek Raman - CppCon 2022](https://youtube.com/watch?v=nzRnWUjGJl8&si=0djsLRaeer54Zc8G)
Neovim for C++: https://www.youtube.com/watch?v=lsFoZIg-oDs

https://github.com/kristijanhusak/neovim-config

Use FZF instead of telescope
* https://github.com/ibhagwan/nvim-lua
* https://github.com/ibhagwan/fzf-lua#why-fzf-lua
* https://github.com/deathmaz/fzf-lua-asynctasks

* https://www.youtube.com/watch?v=stqUbv-5u2s TJ De Vries  Effective Neovim: Instant IDE
* https://codevion.github.io/#!vim/cpp2.md: (Neo)vim for C++ Part 2: CMake, GTest, File Explorer, etc

### Tridactyl

:mktridactylrc => saves settings to rc (location see below)

[location of tridactylrc](https://github.com/tridactyl/native_messenger/blob/000e5f8519b0f94efaa0d8841f3d284e07cdd088/src/native_main.nim#L98-L101)

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

* https://zealdocs.org/
* https://cukic.co/2022/04/02/fuzzy-search-documentation/
* https://gitlab.com/ivan-cukic/zeal-lynx-cli

## Second Brain, PKM, Personal Knowledge Management, Obsidian

* https://www.ssp.sh/blog/obsidian-note-taking-workflow/
* https://www.ssp.sh/brain/
* https://www.ssp.sh/blog/pkm-workflow-for-a-deeper-life/

## Learnings Notes

### generic programming

* https://godbolt.org/z/a4ooYbd1P from [Evolution of a Median Algorithm in C++ - Pete Isensee - CppCon 2023](https://www.youtube.com/watch?v=izxuLq_HZHA&pp=ygUcY3BwIGV2b2x1dGlvbiBtZWFuIGFsZ29yaXRobQ%3D%3D)

### Resources

* https://epage.github.io/dev/

### Code Review

* https://stackoverflow.blog/2019/09/30/how-to-make-good-code-reviews-better/
* https://epage.github.io/dev/code-review/

### Commits

* https://epage.github.io/dev/commits/
* https://cafkafk.dev/p/conventional-commits/

### Planning, Estimating

* https://epage.github.io/dev/planning/

### Testing

* https://epage.github.io/dev/testing/
* [Kevlin Henney - Programming with GUTs - Meeting C++ 2021](https://www.youtube.com/watch?v=cfh6ZrA19r4)
