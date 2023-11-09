#!/bin/bash

mkdir -p .config/tealdeer
mkdir -p .config/bat
mkdir -p .config/clangd
mkdir -p .config/ruff

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
