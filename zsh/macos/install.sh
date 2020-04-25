#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_ALIAS_FILE="$SCRIPT_DIR/alias.zsh"
SRC_EXPORT_FILE="$SCRIPT_DIR/export.zsh"
DEST_DIR="$ZSH/custom"

ln -s $SRC_ALIAS_FILE $DEST_DIR
ln -s $SRC_EXPORT_FILE $DEST_DIR
echo "Success: Symlinked custom files!"
