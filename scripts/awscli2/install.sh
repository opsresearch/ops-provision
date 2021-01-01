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

echo "Script: $0"
cd "$HOME"

if command -v aws > /dev/null; then
    echo "Skipping the installation of awscli2 because the command 'aws' is defined."
    exit 0
fi

# MACOS
if is_macos; then
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg AWSCLIV2.pkg -target / 
    rm -f ./AWSCLIV2.pkg
elif is_linux && is_x86_64; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    if ! command -v aws; then
        sudo ./aws/install
    else
        sudo ./aws/install --update
    fi
    rm -rf ./awscliv2.zip ./aws
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi


