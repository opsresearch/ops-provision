#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$HERE/.."
source "config.sh"
source "funct.sh"
######

cd "$HOME"

# MACOS
if is_macos; then
    brew update
    brew install -f packer
elif type_of_debian; then
    sudo apt update
    sudo apt install -y packer
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

