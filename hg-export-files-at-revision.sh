#!/bin/bash

# dump all files changed at given revision into given directory

REVISION=$1
DESTINATION=$2

if [ -n "$REVISION" ] && [ -n "$DESTINATION" ]; then
    mkdir -p $DESTINATION
    hg archive --type files --rev $REVISION -I $(hg log -r $REVISION --template '{files}\n' | sed 's/\n / -I /g') $DESTINATION
else
    echo -e "`basename $0` revision outputdir"
    echo -e "\twhere revision - revision number or hash"
    echo -e "\toutputdir - destination directory (created if needed)"
fi
