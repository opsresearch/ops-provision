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

if command -v terraform > /dev/null; then
    echo "Skipping Terraform install because the command 'terraform' is defined."
    exit 0
fi

if is_macos; then
    brew update
    brew install -f terraform
elif is_linux_x86_64; then
     sudo wget "https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
    sudo unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
    sudo mv -f terraform /usr/local/bin/
    rm -f "./terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

