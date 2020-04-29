#!/bin/sh

set -e

mkdir -p ~/.ssh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DEST_FILE=~/.ssh/config

if [ -f $DEST_FILE ]; then
    mv $DEST_FILE $DEST_FILE.bak
    echo "Found $DEST_FILE. Move the file to $DEST_FILE.bak"
fi

# Symlink files
ln -s $SCRIPT_DIR/CONFIG $DEST_FILE
echo "Success: Symlinked $DEST_FILE!"
