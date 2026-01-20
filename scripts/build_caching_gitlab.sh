#!/usr/bin/env bash

# @brief    Adapts timestamps of files to enable reuse of targets
#           already built in previous builds.
#
# @details  To enable the reuse of targets built in previous jobs and stored as build
#           artifacts, the timestamps of the source files of the repository must not be
#           newer than the files of the build artifacts. While checking out the
#           repository, the source files get the timestamp of the time the checkout is
#           performed, which is always more recent than the build artifacts from the
#           previous build.
#           To achieve a reuse, the script sets the timestamp of the source files to
#           that of the timestamp of the directory of the build artifacts.
#
#           Gitlab does not synchronize the timestamps of build artifacts between Gitlab
#           runner, resulting in timestamps of the build artifacts being in the future.
#           To prevent this from happening (which result in make warnings), use a
#           workaround:
#           The timestamps of all files and directories of the CMake build artifacts are
#           reduced by 1 minute while preserving the relative order of the timestamps.

set -euo pipefail
IFS=$'\n\t'

# take the timestamp of the build directory
buildArtifactsDirectory="build"

# main part
echo "Modify timestamps at path $buildArtifactsDirectory to enable re-use of targets built in previous jobs."

# Workaround (see @details): Substract timestamp of build artifacts. Substracting by 1
# minute to solve the issue.
touch --time=mtime --reference="$buildArtifactsDirectory" --date "-1 minute" "$buildArtifactsDirectory"
find ./* -path "./$buildArtifactsDirectory/*" -type f,d -exec sh -c 'touch --time=mtime --reference="$0" --date "-1 minute" "$0"' {} \;

# For build artifacts, Gitlab only supports a iso8601 conform timestamp precision down
# to seconds, not nanoseconds.  i.e. nanoseconds are stripped off the timestamp. Gitlab
# doesn't document that, but here you can get an idea:
# https://docs.gitlab.com/search/?q=CI_COMMIT_TIMESTAMP&page=1 -> predefined variables
# So we also only use seconds precision for adapting the timestamp
referenceTimestamp=$(date --reference="$buildArtifactsDirectory" --iso-8601=seconds)

# Set modification timestamps of all source files to that of the build directory to
# enable re-use of targets built in previous build jobs.
#
# Modify source files and files that are needed by CMake (e.g. xml files)
# Exclude paths as an optimization.
# (optional):   Fastest and most generic optimization which files to include would be to
#               use the file entries in the compile_commands.json.
find ./* -not -path ".*/$buildArtifactsDirectory/*" -not -path ".*/.git/*" -type f -exec sh -c 'touch --time=mtime --no-dereference --date "$1" "$0"' {} "$referenceTimestamp" \;
