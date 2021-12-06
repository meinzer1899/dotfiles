#!/bin/bash

tldr --update
zinit self-update
zinit update --parallel
npm install -g npm
~/.tmux/plugins/tpm/bin/update_plugins all
~/.tmux/plugins/tpm/bin/clean_plugins
