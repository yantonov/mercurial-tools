#!/bin/sh

### How to install mercurial from source on mac os

MERCURIAL_VERSION="3.6"
DIST_FILE="mercurial-$MERCURIAL_VERSION.tar.gz"
DESTINATION_FOLDER="$HOME/Development/bin"
DISTR_URL="http://mercurial.selenic.com/release/$DIST_FILE"
EXTRACTED_MERCURIAL_DIR=mercurial-$MERCURIAL_VERSION

WD=`pwd`

# 1. Download latest version of mercurial
echo "1. downloading from $DISTR_URL"
cd $HOME/Downloads
curl -LO $DISTR_URL

# 2. Extract
echo '2. extract'
tar xfz $DIST_FILE

# 3. Go to extract dir
echo '3. go to dir'
cd $EXTRACTED_MERCURIAL_DIR

# 4. Build locally
echo '4. build locally'
make local

# 5. Move to user specific directory
echo '5. move to user specific directory'
mkdir -p $DESTINATION_FOLDER
cd ..
# remove old copy (for idempotent)
rm -rf $DESTINATION_FOLDER/$EXTRACTED_MERCURIAL_DIR
mv $EXTRACTED_MERCURIAL_DIR $DESTINATION_FOLDER

# 6. Make symbolic links
echo '6. make symbolic links'
cd $DESTINATION_FOLDER
# delete old link
rm mercurial
ln -s `pwd`/$EXTRACTED_MERCURIAL_DIR mercurial

# 7. Add $HOME/Development/bin/mercurial to PATH environment
# Add this line to $HOME/.profile
echo '7. Manually add this line to $HOME/.profile:'
echo "'export PATH='$DESTINATION_FOLDER'/mercurial:\$PATH'"
export PATH=$DESTINATION_FOLDER/mercurial:$PATH

# 8. reload .profile
echo '8. reload .profile'
echo 'source $HOME/.profile'

# 9. Check
echo '9. check'
output=`hg --version | grep "Mercurial Distributed SCM"`
if [ -z "$output" ]; then
    echo "[ERROR] - something wrong, check PATH variable"
    echo $output
    echo "current PATH value: $PATH"
    exit 0
fi
echo 'ok - mercurial is installed successfully'
# you should see something like this:

# Mercurial Distributed SCM (version 3.2.3)
# (see http://mercurial.selenic.com for more information)
# Copyright (C) 2005-2014 Matt Mackall and others
# This is free software; see the source for copying conditions. There is NO
# warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

# 10. Clean up
echo '10. cleanup'
cd $HOME/Downloads
rm -rf $DIST_FILE

cd $WD
