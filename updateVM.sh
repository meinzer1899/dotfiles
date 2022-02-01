#!/bin/bash

tldr --update

# zinit update --parallel && zinit self-update

npm install -g npm

~/.tmux/plugins/tpm/bin/update_plugins all
~/.tmux/plugins/tpm/bin/clean_plugins

# cargo install cargo-update is needed
cargo install-update -a
