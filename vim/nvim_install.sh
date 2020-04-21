#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
VIM_INSTALL_FILE="$SCRIPT_DIR/vim_install.sh"
SRC_INIT_FILE="$SCRIPT_DIR/nvim/init.vim"
DEST_INIT_FILE=~/.config/nvim/init.vim

# run vim setup
sh $VIM_INSTALL_FILE
echo "Success: Installed Vim dot files!"

if [ -f $DEST_INIT_FILE ]; then
    echo "Error: ~/.config/nvim/init.vim file already exists."
    exit 2
fi

mkdir -p ~/.config/nvim

# Symlink files
ln -s $SRC_INIT_FILE $DEST_INIT_FILE
echo "Success: Symlinked init.vim file!"
