#!/bin/env bash

# enable bash strict mode
# (http://redsymbol.net/articles/unofficial-bash-strict-mode/)
set -uo pipefail; shopt -s failglob # safe mode, errexit not useful here
IFS=$'\n\t'

set -x

echo "Starting update"

tldr --update

# javascript tool manager, installs node.js runtimes, npm and Yarn package managers or any binary from npm
volta install node@lts # installs latest LTS; node@20 installs latest node 20 version
# https://docs.npmjs.com/about-npm-versions recommends to install latest version
volta install npm@bundled # needed for coc plugin install, @latest also available
volta install bash-language-server
# from time to time, uninstall old package versions via rm -rf in ~/.volta/tools/image/[node|npm]
zsh -lc "eza --tree -L2 '$HOME/.volta/tools/image/'"

# fails when called outside of tmux session
if [[ -n $TMUX  ]]; then
    ~/.tmux/plugins/tpm/bin/clean_plugins
    ~/.tmux/plugins/tpm/bin/update_plugins all
fi

# cargo install cargo-update is needed
# cargo install-update -a

# gets updated via zi
# pip (https://www.mankier.com/1/pip#Commands)
python3 -m pip install --upgrade pip
python3 -m pip install git+https://github.com/Vimjas/vint.git  #has to be pre (https://github.com/iamcco/coc-diagnostic/issues/62#issuecomment-735660297)

# vim
vim +PlugUpdate +CocUpdateSync +PlugClean! +qall

# tmux
# manually via repository

# alacritty
# manually via repository
echo "Updating done"
exit 0
