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

cd "$REPO_ROOT"

if command -v python3 > /dev/null; then
    echo "Skipping, Python3 is already installed."
    exit 0
fi

# MACOS
if is_macos; then
    brew update
    brew install -f python3
elif type_of_debian; then
    sudo apt update
    sudo apt install -y python3 python3-pip
elif type_of_rhel; then
    sudo yum update
    sudo yum install -y python3 python3-pip
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

python3 -m pip install --upgrade pip
