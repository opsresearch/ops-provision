#!/usr/bin/env bash
# Copyright (c) 2020-Present OpsResearch LLC
# Licensed under the MIT License, see the LICENSE file.
set -euo pipefail
IFS=$'\n\t'
export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$HERE"
source "config.sh"
source "funct.sh"
######

# SSH
ssh/init-user.sh 'NO-PASSPHRASE' 

# BASE
base/install.sh

# AWSCLI2
awscli2/install.sh

# DEVELOPMENT
development/install.sh

# MARIADB
mariadb/install.sh
mariadb/enable.sh 
mariadb/disable.sh

# PACKER
packer/install.sh

# POSTGRES
postgres/install.sh
postgres/enable.sh
postgres/disable.sh

# PYTHON3
python3/install.sh
python3/init-user.sh
python3/create-venv.sh "$HOME" venv

# SBCL
sbcl/install.sh
sbcl/init-user.sh

# TERRAFORM
terraform/install.sh


