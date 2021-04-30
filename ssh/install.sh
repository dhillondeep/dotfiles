#!/bin/bash

set -e

mkdir -p ~/.ssh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DEST_FILE=~/.ssh/config

if [ -f $DEST_FILE ]; then
    mv $DEST_FILE $DEST_FILE.bak
    echo "Found $DEST_FILE. Move the file to $DEST_FILE.bak"
fi

# Symlink files
ln -s $SCRIPT_DIR/config $DEST_FILE
echo "Success: Symlinked $DEST_FILE!"

# Gen ssh key
ssh-keygen -t ed25519 -C "deep@dhillon.io"
