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

if is_macos; then
    brew update
    brew install -f postgresql
elif type_of_debian; then
    sudo apt update -y
    sudo apt install -y postgresql postgresql-contrib
elif type_of_rhel; then
    sudo yum update -y
    sudo yum install -y postgresql postgresql-server postgresql-contrib
else
    echo "This OS isn't suitable for: $0"
    uname -a
    exit 1
fi

if ! sudo postgresql-setup initdb; then
    echo "Initdb failed, possibly the Postgresql database was already initialized."
fi

