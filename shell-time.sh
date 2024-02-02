#!/usr/bin/env bash
for _ in $(seq 10); do zsh -ic "zi times -sma | rg Total"; done
