#!/usr/bin/env bash
# Copyright (c) 2020-Present OpsResearch LLC
# Licensed under the MIT License, see the LICENSE file.
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
######

if is_macos; then
    pg_sudo(){
        "$@"
    }
elif is_linux;  then
    pg_sudo(){
        sudo -u "$@"
    }
fi

run_as(){ # ARGS: <user-name> <script> [arg1 [arg2] ...]
    local_user=$1
    shift
    script=$1
    shift
    if [ "$local_user" = "$USER" ];then
        "$script" "$@"
    else
        sudo su "$local_user" -c "$script" "$@"
    fi
}
