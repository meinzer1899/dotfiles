#!/usr/bin/env bash

# see also https://github.com/stephenberry/glaze/blob/main/util/run_clang-format.sh

# @brief  Checks sources formatting with clang-format on files that differ from $CI_DEFAULT_BRANCH (defaults
# to main if not set).

# @details  Files and directories are excluded when the caller sets a (extended) regex pattern EXCLUDE_PATTERN.

# Documentation for set and shopt: https://www.gnu.org/software/bash/manual/html_node/Modifying-Shell-Behavior.html no -o errexit, because grep
# returns error code if no match was found
set -o pipefail -o nounset
IFS=$'\n\t'

print_message_and_exit() {
    echo -e "$1\nExiting."
    exit 0
}

files()
{
    local filetypes='.*\.([cht]pp|[ch])\b'
    # using merge-base instead of plain origin/main to get rid of check if file is present locally which is
    # not the case if file was added only to remote but is not present in HEAD
    git diff "$(git merge-base origin/"${CI_DEFAULT_BRANCH:="main"}" HEAD)" --name-only | grep -E "$filetypes";
}

if [[ -n ${EXCLUDE_PATTERN:=""} ]]; then
    exclude() { grep -Ev "$EXCLUDE_PATTERN"; }
else
    exclude() { cat; }
fi;

# grep exits with error code 1 if no match is found
files_to_check=$(files | exclude) || print_message_and_exit "No files found to format."
# shellcheck disable=SC2086
# I want word splitting here
clang-format --dry-run --ferror-limit=0 --Werror $files_to_check

# version using for loop instead of variable expansion via IFS and condition check if file exists locally

# no -o errexit, because clang-format exits we want clang-format to check all files first independent of error code
#ret=0
#for FILE in $files
#do
#    if [[ ! -e $FILE ]]; then
#        # if file exists on target ($CI_DEFAULT_BRANCH) but not in source (local) branch, clang-format emits "No such file or directory"
#        continue
#    fi
#    # we set error code but don't care about clang-format error code (which is not documented in man page anyway)
#    clang-format --dry-run --ferror-limit=0 --Werror "$FILE" || ret=1
#done

#exit $ret
