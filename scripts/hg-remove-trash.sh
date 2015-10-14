#!/bin/bash

# remove trash tracked files

# tracked files
# orig files
hg remove "glob:**.orig"
# rejected files
hg remove "glob:**.rej"

# YOU MUST ENABLE PURGE EXTENSION TO USE IT
# edit hgrc file and edit extension settings
# [extensions]
# purge =
# untracked files
# orig files
hg purge "glob:**/*.orig" --all
# rej files
hg purge "glob:**/*.rej" --all
