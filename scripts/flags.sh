#!/usr/bin/env bash

set -euo pipefail; shopt -s failglob # safe mode

printf "Example bash script of using shell script flags\n"

dir="$(dirname "$0")"
keep_open=false

usage () {
    echo "Usage: $(basename "$0") [OPTIONS...]"
    echo "  -k        --keep-open     Keep lnks open after selecting a bookmark"
    echo "  -d <dir>  --dir <dir>     Specify a directory where bookmarks files are stored"
    exit 0
}


while [[ "$#" -gt 0 ]]; do
    case $1 in
        -k|--keep-open) keep_open=true ;;
        -d|--dir) dir="$2"; shift ;;
        -h|--help) usage ;;
        *) echo "Unknown parameter passed: $1" >&2; exit 1 ;;
    esac
    shift
done
