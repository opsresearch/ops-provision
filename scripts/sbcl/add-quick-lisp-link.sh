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

usage(){
    echo "Usage: add-quick-lisp-link.sh <system-name> <system-dir>"
    exit 1
}

if [ $# -ne 2 ]; then
    echo "Invalid number of arguments."
    usage
fi 

if [ ! -d "$HOME/quicklisp/local-projects" ]; then
    echo "Quicklisp is not installed: $HOME/quicklisp/local-projects"
    usage
fi 

if [ ! -d "$2" ]; then
    echo "Not a directory: $2"
    usage
fi 

if [ ! -d "$HOME/quicklisp/local-projects/$1" ];then
    ln -s "$2" "$HOME/quicklisp/local-projects/$1"
else
    echo "Skipping $1 because it is already linked."
fi