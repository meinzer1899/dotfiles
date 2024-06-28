#!/usr/bin/env bash

# @brief  Checks sources formatting with clang-format on files that differ from $CI_DEFAULT_BRANCH (defaults to main if not set).
#
# @details  Files and directories are excluded when the caller sets a (extended) regex pattern EXCLUDE_PATTERN.

set -o pipefail -o nounset
# no -o errexit, because we want clang-format to check all files first independent of error code
IFS=$'\n\t'

files()
{
    git diff origin/"${CI_DEFAULT_BRANCH:="main"}" --name-only | grep -E '.*\.(c|cpp|h|hpp|tpp)\b';
}

if [[ -n ${EXCLUDE_PATTERN:=""} ]]; then
    exclude() { grep -Ev "$EXCLUDE_PATTERN"; }
else
    exclude() { cat; }
fi;

files=$(files | exclude)

ret=0
for FILE in $files
do
    if [[ ! -e $FILE ]]; then
        # if file exists on target ($CI_DEFAULT_BRANCH) but not in source (local) branch, clang-format emits "No such file or directory"
        #TODO: investigate if this condition can be removed by using
        # git diff $(git merge-base origin/main HEAD) in function files()
        continue
    fi
    # we set error code but don't care about clang-format error code (which is not documented in man page anyway)
    clang-format --dry-run --ferror-limit=0 --Werror "$FILE" || ret=1
done

exit $ret
