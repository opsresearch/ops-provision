#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$HERE"
source "config.sh"
source "funct.sh"
######

find "$HERE" -name '*.sh'   -exec chmod u+x {} \;
find "$HERE" -name '*.lisp' -exec chmod u+x {} \;
find "$HERE" -name '*.py'   -exec chmod u+x {} \;
find "$HERE" -name '*.sh'   -exec shellcheck -x {} \;
