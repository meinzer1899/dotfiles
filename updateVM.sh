#!/bin/bash

tldr --update

# zinit update --parallel && zinit self-update

# NODE_VERSION=16.14.0
# nvm install ${NODE_VERSION} && nvm use ${NODE_VERSION}
# nvm install-latest-npm

~/.tmux/plugins/tpm/bin/update_plugins all
~/.tmux/plugins/tpm/bin/clean_plugins

# cargo install cargo-update is needed
cargo install-update -a

# pip
pip install -U pip
pip freeze --local | tee before_upgrade.txt | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
