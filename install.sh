#!/usr/bin/env bash

set -euo pipefail; shopt -s failglob # safe mode
IFS=$'\n\t'

# https://docs.volta.sh/guide/getting-started
if [[ -d ~/.volta ]]; then
    curl https://get.volta.sh | bash -s -- --skip-setup
fi
