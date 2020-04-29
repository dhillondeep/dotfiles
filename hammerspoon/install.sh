#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_FILE="$SCRIPT_DIR/init.lua"
DEST_FILE=~/.hammerspoon/init.lua

if [ -f $DEST_FILE ]; then
    mv $DEST_FILE $DEST_FILE.bak
    echo "Found $DEST_FILE. Move the file to $DEST_FILE.bak"
fi

# Symlink init.lua file
ln -s $SRC_FILE $DEST_FILE
echo "Success: Symlinked $DEST_FILE file!"
