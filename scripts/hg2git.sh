#/bin/bash

# script creates git repo from hg (mercurial) repo using fast-export tool

tempDirectory="tmp-"`date +%s`

function get_working_directory_path() {
    echo "/tmp/$tempDirectory"
}

function create_directory() {
    path=$1
    echo "creating directory \"$path\""
    echo "mkdir $path"
    mkdir $path
}

function remove_directory() {
    path=$1
    echo "removing directory \"$path\""
    echo "rm -rf $path"
    rm -rf $path
}

WD=`pwd`
if [ $# -lt 3 ]; then
    echo "Usage: hg_repo where_to_place_new_repo new_repo_name"
    exit 0
else
    HG_REPO=$1
    WHERE_TO_PLACE_NEW_REPO=$2
    NEW_REPO_NAME=$3

    if [ ! -d $WHERE_TO_PLACE_NEW_REPO]; then
        echo "Destination dir : $WHERE_TO_PLACE_NEW_REPO does not exists."
    fi

    # create tmp dir
    workingDirectory=`get_working_directory_path`
    create_directory $workingDirectory
    cd $workingDirectory

    # clone fast-export
    git clone http://repo.or.cz/r/fast-export.git

    # create clean repo
    git init $NEW_REPO_NAME
    cd $NEW_REPO_NAME
    NEW_REPO_PATH=`pwd`

    # convert
    ../fast-export/hg-fast-export.sh -r $HG_REPO

    # vuala
    git checkout HEAD

    # place new repo to dest
    cd $WHERE_TO_PLACE_NEW_REPO
    git clone $NEW_REPO_PATH

    # cleanup
    remove_directory $workingDirectory
fi
cd $WD
