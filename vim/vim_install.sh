#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_CONFIGS_FILE="$SCRIPT_DIR/vim/my_configs.vim"
SRC_PLUGINS_FILE="$SCRIPT_DIR/vim/my_plugins.vim"
DEST_CONFIGS_FILE=~/.vim_runtime/my_configs.vim
DEST_PLUGINS_FILE=~/.vim_runtime/my_plugins.vim

# check if ~/.vim_runtime exists
if [ -d ~/.vim_runtime ]; then
    echo "Error: ~/.vim_runtime already exists"
    exit 1
fi

# install dhillondeep/vimrc
git clone --depth=1 https://github.com/dhillondeep/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Symlink files
ln -s $SRC_CONFIGS_FILE $DEST_CONFIGS_FILE
ln -s $SRC_PLUGINS_FILE $DEST_PLUGINS_FILE
echo "Success: Symlinked my_configs.vim and my_plugins.vim!"
