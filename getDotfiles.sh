#!/bin/bash

test -d .config/tealdeer || mkdir -p .config/tealdeer
test -d .config/bat || mkdir -p .config/bat
test -d .config/clangd || mkdir -p .config/clangd
test -d .config/ruff || mkdir -p .config/ruff

cp ~/.config/tealdeer/config.toml .config/tealdeer/
cp ~/.config/bat/config .config/bat/
cp ~/.config/clangd/config.yaml .config/clangd/
cp ~/.config/ruff/.ruff.toml .config/ruff/

cp -t . \
    ~/.zshrc \
    ~/.zshenv \
    ~/.vimrc \
    ~/.tmux.conf \
    ~/.vim/coc-settings.json \
    ~/.alacritty.yml \
    ~/.gitconfig
    ~/.shellcheckrc

echo "Done"
exit 0
