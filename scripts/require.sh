#!/usr/bin/env bash

set -euo pipefail

require() {
      command -v "$1" > /dev/null 2>&1 || {
              echo "missing command: $1" >&2
              exit 1
            }
    }

# passes
require shellcheck
# fails
require garbage-command-i-invented-just-now
