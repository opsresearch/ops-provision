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

usage(){
    echo "Usage: ssh/init-user.sh (<passphrase> | NO-PASSPHRASE | PROMPT-PHRASE)"
    exit 1
}

create_ssh_config(){
tee .ssh/config <<EOF >/dev/null
Host *
    ServerAliveInterval 300
    ServerAliveCountMax 2
    ForwardAgent yes
    
EOF
}

if [ $# -lt 1 ];then
    usage
fi

# .SSH DIR
if [ ! -d .ssh ]; then
	mkdir .ssh
	chmod 755 .ssh
fi

# KEYS
if [ -f .ssh/id_rsa ] || [ -f .ssh/id_rsa.pub ]; then
    echo "Skipping key generation because one or more keys exist."
else
    if [ "$1" =  "NO-PASSPHRASE" ]; then
        ssh-keygen -b 2048 -t rsa -f ".ssh/id_rsa" -q -N ""
    elif [ "$1" =  "PROMPT-PASSPHRASE" ]; then
        ssh-keygen -b 2048 -t rsa -f ".ssh/id_rsa" -q
    else
        ssh-keygen -b 2048 -t rsa -f ".ssh/id_rsa" -q -N "$1"
    fi
fi

# CONFIG
if [ -f .ssh/config ]; then
    echo "Skipping ~/.ssh/config creation because it already exists."
else
    create_ssh_config
fi

