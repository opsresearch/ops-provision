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

init_quicklisp(){
sbcl --load quicklisp.lisp << EOF
(quicklisp-quickstart:install)
(quit)
EOF
}

init_sbclrc(){
tee .sbclrc <<EOF >/dev/null

;;; The following lines added by ql:add-to-init-file:
#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                    (user-homedir-pathname))))
(when (probe-file quicklisp-init)
(load quicklisp-init)))


;;; The following lines added by ql:add-to-init-file:
#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                    (user-homedir-pathname))))
(when (probe-file quicklisp-init)
(load quicklisp-init)))

EOF
}

if [ -d quicklisp ]; then
    echo "Skipping quicklisp setup because ~/quicklisp exists."
else
    curl -O "https://beta.quicklisp.org/quicklisp.lisp"
    init_quicklisp
    init_sbclrc
    rm quicklisp.lisp
fi
 
