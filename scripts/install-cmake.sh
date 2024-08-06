#!/usr/bin/env bash
# https://github.com/foonathan/docker/blob/main/common/install-cmake.sh

set -e -o pipefail -o nounset

VERSION="3.30.2"
MIRROR_URL="https://github.com/Kitware/CMake/releases/download/v$VERSION/"
DOWNLOAD_X86="cmake-$VERSION-linux-x86_64.sh"
DOWNLOAD_ARM="cmake-$VERSION-linux-aarch64.sh"
DOWNLOAD_FILE="cmake.sh"

if [ $(uname -m) = "x86_64" ]; then
    DOWNLOAD=$DOWNLOAD_X86
elif [ $(uname -m) = "aarch64" ]; then
    DOWNLOAD=$DOWNLOAD_ARM
else
    echo "unknown architecture" >/dev/stderr
    exit 1
fi

# Download
echo "Downloading ${DOWNLOAD}"
curl -L "${MIRROR_URL}/${DOWNLOAD}" --output "${DOWNLOAD_FILE}"

# Install
echo "Installing CMake"
bash "${DOWNLOAD_FILE}" --skip-license --prefix=/usr/local --exclude-subdir

# Cleanup
rm "${DOWNLOAD_FILE}"
