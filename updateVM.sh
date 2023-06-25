#!/bin/bash

tldr --update

# https://wiki.zshell.dev/docs/guides/commands
zi update --all --parallel --quiet

# installs latest LTS with volta
volta install node
# from time to time, uninstall old node versions via rm -rf in ~/.volta/tools/image/node/<version>

~/.tmux/plugins/tpm/bin/update_plugins all
~/.tmux/plugins/tpm/bin/clean_plugins

# cargo install cargo-update is needed
cargo install-update -a

# pip
pip install -U pip
pip freeze --local | tee before_upgrade.txt | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

# vim
vim +PlugUpdate +CocUpdate +PlugClean! +qall

# tmux
# manual via repository
#
# ripgrep rg, fd and bat
# because of bug (error command rg ...) in fzf.vim (or vim shellescape) when calling Rg or RG
#
sudo cp ~/.zi/plugins/sharkdp---bat/bat/bat ~/.zi/plugins/sharkdp---fd/fd/fd ~/.zi/plugins/BurntSushi---ripgrep/target/release/rg /usr/local/bin
#
#
# hadolint
# https://github.com/hadolint/hadolint
# tip: download release binary, cp to /usr/bin
#
# fzf-git.sh
# cd ~/fzf-git.sh && git pull
