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

# MACOS
if is_macos; then
    if command -v brew > /dev/null; then
        echo "Skipping Brew install because the command 'brew' is defined."
        exit 0
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew doctor
    brew update
elif type_of_debian; then
    sudo apt update
    sudo apt install -y unzip zip
elif type_of_rhel; then
    sudo yum update
    sudo yum install -y unzip zip
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

