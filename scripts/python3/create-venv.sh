#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$HERE/.."
source "config.sh"
source "funct.sh"
######

usage(){
    echo "Usage: create-venv.sh <directory> <name>"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

if [ ! -d "$1" ];then
    echo "Can't find the directory: $1"
    exit 1
fi

cd "$1"

export PIP_REQUIRE_VIRTUALENV=false
python3 -m pip install --upgrade pip
python3 -m pip install virtualenv
export PIP_REQUIRE_VIRTUALENV=true

if [ ! -d "$2" ]; then
    python3 -m virtualenv "$2"
else
    echo "Skipping venv creation because the directory exists: $1/$2"
fi

# Upgrade venv
#shellcheck disable=SC1090
source "$2/bin/activate"
python3 -m pip install --upgrade pip
deactivate
