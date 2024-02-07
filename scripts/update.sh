#!/bin/env bash

# enable bash strict mode
# (http://redsymbol.net/articles/unofficial-bash-strict-mode/)
set -eo pipefail
IFS=$'\n\t'

echo "Starting update"
tldr --update

# https://wiki.zshell.dev/docs/guides/commands
# zi update --all --parallel --quiet && zi self-update
# zsh -lic "zi update --all --quiet"

# rg, fd and bat
# because of bug (error command rg ...) in fzf.vim (or vim shellescape) when calling Rg or RG,
# I need the executables also in /usr/local/bin (symlink not working)
cp -vt ~/.zi/polaris/bin ~/.zi/plugins/sharkdp---fd/fd/fd ~/.zi/plugins/sharkdp---bat/bat/bat ~/.zi/plugins/BurntSushi---ripgrep/ripgrep/rg
sudo cp -vt /usr/local/bin ~/.zi/polaris/bin/{bat,fd,rg}

# javascript tool manager, installs node.js runtimes, npm and Yarn package managers or any binary from npm
volta install node@lts # installs latest LTS; node@20 installs latest node 20 version
volta install bash-language-server
# https://docs.npmjs.com/about-npm-versions recommends to install latest version
volta install npm@latest # needed for coc plugin install
# from time to time, uninstall old package versions via rm -rf in ~/.volta/tools/image/[node|npm]

# fails when called outside of tmux session
if [[ -n $TMUX  ]]; then
    ~/.tmux/plugins/tpm/bin/clean_plugins
    ~/.tmux/plugins/tpm/bin/update_plugins all
fi

# cargo install cargo-update is needed
# cargo install-update -a

# gets updated via zi
# pip
pip install --upgrade pip
# pip freeze --local | tee before_upgrade.txt | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

# vim
vim +PlugUpdate +CocUpdateSync +PlugClean! +qall

# tmux
# manually via repository

# alacritty
# manually via repository
echo "Updating done"
exit 0
