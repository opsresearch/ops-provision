#!/usr/bin/env bash
# Copyright (c) 2020-Present OpsResearch LLC
# Licensed under the MIT License, see the LICENSE file.
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$HERE/.."
source "config.sh"
source "funct.sh"
######

cd "$HOME"

if command -v sbcl > /dev/null; then
    echo "Skipping SBCL install because the command 'sbcl' is defined."
    exit 0
fi

install_sbcl_linux_x86_64(){
    if ! command -v shellcheck; then
        cd /tmp
        wget -qO- "http://prdownloads.sourceforge.net/sbcl/sbcl-${OPS_SBCL_VERSION}-x86-64-linux-binary.tar.bz2" | tar -xjv
        cd sbcl-${OPS_SBCL_VERSION}-x86-linux
        sudo sh install.sh
        cd ..
        rm -rf sbcl-${OPS_SBCL_VERSION}-x86-linux
    fi
}

if is_macos; then
    brew update
    brew install -f sbcl
elif is_linux && is_x86_64; then
    install_sbcl_linux_x86_64
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

