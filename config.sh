#!/usr/bin/env bash
# @K.Dziuba
# Etc Update for Arch-like systems - Config File


# ===========================
#  General settings
# ===========================

# Please choose your favourite diff-tool. 
# Examples: vimdiff, meld, kompare, kdiff3.
# ( This is the application that is going to be used to compare and manage changes in files ).
diffToolApp='meld'


# ===================================
#  Auth settings
# ===================================
# enable root authentication types
# -----------------------------------

# enable for sudo authentication (recommended)
authWithSudo='yes'

# enable for polkit/pkexec authentication (GUI only)
# authWithPkexec='yes'

# enable for zensu authentication
# authWithZensu='yes'

# enable for gksu authentication
# authWithGksu='yes'
