#!/usr/bin/env bash

# @brief  Checks sources formatting with clang-format on files that differ from $CI_DEFAULT_BRANCH (defaults to main if not set).
#
# @details  Files and directories are excluded when the caller sets a (extended) regex pattern EXCLUDE_PATTERN.

set -euo pipefail
IFS=$'\n\t'

files()
{
    git diff origin/"${CI_DEFAULT_BRANCH:="main"}" --name-only | grep -E '.*\.(c|cpp|h|hpp|tpp)\b';
}

if [[ -n ${EXCLUDE_PATTERN:=""} ]]; then
    exclude() { cat; }
else
    # exclude() { grep -Ev "$EXCLUDE_PATTERN"; }
    exclude() { printf "hello"; }
fi;

files=$(files | exclude)

ret=0
for FILE in $files
do
    # if file exists on target ($CI_DEFAULT_BRANCH) but not in source (local) branch, clang-format emits "No such file or directory"
    if [[ -e $FILE ]]; then
        # we want to exit with error code but only after checking all files
        clang-format --dry-run --ferror-limit=0 --Werror "$FILE" || ret=$?
    fi
done

exit $ret
