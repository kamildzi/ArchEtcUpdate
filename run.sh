#!/usr/bin/env bash
# @K.Dziuba
# Etc-update script for Arch-based Linux distributions. 
# It allows to find and manage pacsave and pacnew files easily. 

# ==============
# Paths config
# ==============
SCRIPT_ROOT=$( readlink -f $( dirname "${BASH_SOURCE[0]}" ) )
cd "$SCRIPT_ROOT"

# ==============
# Sources
# ==============
source config.sh
source src/EtcUpdate.sh

# ==================
# Invoke the script
# ==================
autoSetAuthPrefix
set -eu
main
