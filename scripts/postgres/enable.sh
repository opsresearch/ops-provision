#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$HERE/.."
source "config.sh"
source "funct.sh"
######

if is_macos; then
    brew services start postgresql
elif type_of_debian; then
    sudo systemctl enable postgresql
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi
