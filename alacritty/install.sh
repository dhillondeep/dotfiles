#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_FILE="$SCRIPT_DIR/alacritty.yml"
DEST_FILE=~/.config/alacritty/alacritty.yml

mkdir -p ~/.config/alacritty

if [ -f $DEST_FILE ]; then
    echo "Error: Cannot link because $DEST_FILE exists."
    exit 1
fi

# Symlink .zshrc file
ln -s $SRC_FILE $DEST_FILE
echo "Success: Symlinked ~/.zshrc file!"
