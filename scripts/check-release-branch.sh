#!/bin/bash

REPO_ROOT="$(hg root)"

if [ -z "$REPO_ROOT" ]; then
    echo 'hg root is not found'
    echo 'run this script inside hg repository'
    exit 1
fi

BRANCH="$(hg branch)"

hg log \
   -G \
   -r "reverse(::${BRANCH})" \
   --template '{label(red,node|short)} | {label(yellow, branch)} | {date|isodatesec} | {label(blue, author|user)}: {label(green, desc|strip|firstline)}\n'

