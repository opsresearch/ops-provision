#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$HERE/.."
source "config.sh"
source "funct.sh"
######

# MACOS
if is_macos; then
    if ! grep PIP_REQUIRE_VIRTUALENV "$HOME/.zshrc" > /dev/null; then
        echo 'export PIP_REQUIRE_VIRTUALENV=true' >> "$HOME/.zshrc"
    fi
elif is_linux; then
    if ! grep PIP_REQUIRE_VIRTUALENV "$HOME/.bashrc" > /dev/null; then
        echo 'export PIP_REQUIRE_VIRTUALENV=true' >> "$HOME/.bashrc"
    fi
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

