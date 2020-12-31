#!/usr/bin/env bash
# Copyright (c) 2020-Present OpsResearch LLC
# Licensed under the MIT License, see the LICENSE file.
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
######

export REPO_ROOT
REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../" && pwd )"

set +u
if [ -z "$OPS_TERRAFORM_VERSION" ]; then
    export OPS_TERRAFORM_VERSION="0.14.3"
fi
set -u

############

is_linux(){
    [ "$(uname)" = 'Linux' ]
}

is_x86_64(){
    [ "$(uname -m)" = 'x86_64' ]
}

is_arch_64(){
    [ "$(uname -m)" = 'aarch64' ]
}

is_macos(){
    [ "$(uname)" = 'Darwin' ]
}

is_ubuntu(){
    grep Ubuntu /etc/os-release > /dev/null
}

is_raspi(){
    grep Raspberry /etc/os-release > /dev/null
}

is_debian(){
    grep Debian /etc/os-release > /dev/null
}

type_of_debian(){
    command -v apt-get
}

is_rhel(){
    grep "Red Hat" /etc/os-release > /dev/null
}

is_centos(){
    grep "Centos" /etc/os-release > /dev/null
}

type_of_rhel(){
    command -v yum
}


