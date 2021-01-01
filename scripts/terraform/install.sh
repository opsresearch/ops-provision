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

echo "Terraform version: $OPS_TERRAFORM_VERSION"

if command -v terraform > /dev/null; then
    echo "Skipping Terraform install because the command 'terraform' is defined."
    exit 0
fi

install_terraform_linux_x86_64(){
    if ! command -v terraform > /dev/null; then
        sudo wget "https://releases.hashicorp.com/terraform/$OPS_TERRAFORM_VERSION/terraform_${OPS_TERRAFORM_VERSION}_linux_amd64.zip"
        sudo unzip "terraform_${OPS_TERRAFORM_VERSION}_linux_amd64.zip"
        sudo mv -f terraform /usr/local/bin/
        rm -f "./terraform_${OPS_TERRAFORM_VERSION}_linux_amd64.zip"
    fi
}

if is_macos; then
    brew update
    brew install -f terraform
elif is_linux && is_x86_64; then
    install_terraform_linux_x86_64
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

