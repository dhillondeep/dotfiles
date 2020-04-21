#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_CONFIGS_FILE="$SCRIPT_DIR/vim/my_configs.vim"
SRC_PLUGINS_FILE="$SCRIPT_DIR/vim/my_plugins.vim"
SRC_COC_EXTENSIONS="$SCRIPT_DIR"/coc.vim/coc-settings.json
SRC_COC_EXTENSIONS="$SCRIPT_DIR"/coc.vim/extensions
DEST_CONFIGS_FILE=~/.vim_runtime/my_configs.vim
DEST_PLUGINS_FILE=~/.vim_runtime/my_plugins.vim
DEST_COC_CONFIG_FILE=~/.vim/coc-settings.json
DEST_COC_EXTENSIONS=~/.config/coc/extensions

# check if ~/.vim_runtime exists
if [ -d ~/.vim_runtime ]; then
    echo "Error: ~/.vim_runtime already exists."
    exit 1
fi

# check if ~/.vimrc exists
if [ -f ~/.vimrc ]; then
    echo "Error: ~/.vimrc file already exists."
    exit 1
fi

# install dhillondeep/vimrc
git clone --depth=1 https://github.com/dhillondeep/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# Symlink files
ln -s $SRC_CONFIGS_FILE $DEST_CONFIGS_FILE
ln -s $SRC_PLUGINS_FILE $DEST_PLUGINS_FILE
ln -s $SRC_COC_CONFIG_FILE $DEST_COC_CONFIG_FILE
ln -s $SRC_COC_EXTENSIONS $DEST_COC_EXTENSIONS
echo "Success: Symlinked all the vim config files!"
