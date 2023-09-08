#!/bin/bash

tldr --update

# https://wiki.zshell.dev/docs/guides/commands
zi update --all --parallel --quiet && zi self-update

# ripgrep rg, fd and bat
# because of bug (error command rg ...) in fzf.vim (or vim shellescape) when calling Rg or RG
sudo cp -t /usr/local/bin ~/.zi/polaris/bin/{bat,fd,rg}

# javascript tool manager, installs node.js runtimes, npm and Yarn package managers or any binary from npm
volta install node # installs latest LTS
volta install bash-language-server
volta install npm # do I need npm or does volta do the job?
# from time to time, uninstall old package versions via rm -rf in ~/.volta/tools/image/[node|npm]

~/.tmux/plugins/tpm/bin/update_plugins all
~/.tmux/plugins/tpm/bin/clean_plugins

# cargo install cargo-update is needed
cargo install-update -a

# pip
pip install -U pip
pip freeze --local | tee before_upgrade.txt | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

# vim
vim +PlugUpdate +CocUpdateSync +PlugClean! +qall

# tmux
# manually via repository

# alacritty
# manually via repository

# hadolint
# https://github.com/hadolint/hadolint
# TODO: install via zi
