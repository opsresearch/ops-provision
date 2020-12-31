#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
pushd "$HERE" > /dev/null
source "config.sh"
source "funct.sh"
######

popd > /dev/null

usage(){
    echo "Usage: run-as.sh <user-name> <script> [arg1 [arg2] ...]"
    exit 1
}

if [ $# -lt 2 ]; then
    usage
fi

run_as "$@"
