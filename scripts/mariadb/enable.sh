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

if is_macos; then
    brew services start mariadb
elif is_linux; then
    sudo systemctl enable mariadb.service
    sudo systemctl start mariadb.service
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi
