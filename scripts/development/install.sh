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

install_rhel_shellcheck(){
    if ! command -v shellcheck; then
        cd /tmp
        wget -qO- "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz" | tar -xJv
        sudo mv "shellcheck-stable/shellcheck" /usr/bin/
        rm -rf shellcheck-stable
    fi
}

if is_macos; then
    brew update
    brew install -f shellcheck
elif type_of_debian; then
    sudo apt update
    sudo apt install -y shellcheck
elif type_of_rhel; then
    install_rhel_shellcheck
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi
