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

if is_macos; then
    brew update
    brew install -f shellcheck
elif type_of_debian; then
    sudo apt update
    sudo apt install -y shellcheck
elif type_of_rhel; then
    sudo yum update
    sudo yum install -y shellcheck
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi
