#!/bin/bash

mkdir -p .config/tealdeer
mkdir -p .config/bat

cp ~/.zshrc .
cp ~/.vimrc .
cp ~/.tmux.conf .
cp ~/.vim/coc-settings.json .
cp ~/.alacritty.yml .
cp ~/.config/tealdeer/config.toml .config/tealdeer/
cp ~/.config/bat/config .config/bat/
