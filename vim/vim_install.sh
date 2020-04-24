#!/bin/sh

set -e

# install ~/.vim_runtime if it does not exist
if [ ! -d ~/.vim_runtime ]; then
    git clone --depth=1 https://github.com/dhillondeep/vimrc ~/.vim_runtime
fi

sh ~/.vim_runtime/install_awesome_vimrc.sh

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_COC_CONFIG_FILE="$SCRIPT_DIR"/coc.vim/coc-settings.json
SRC_COC_EXTENSIONS="$SCRIPT_DIR"/coc.vim/extensions
DEST_COC_CONFIG_FILE=~/.vim/coc-settings.json
DEST_COC_EXTENSIONS=~/.config/coc/extensions

if [ -d $DEST_COC_EXTENSIONS ]; then
    mv $DEST_COC_EXTENSIONS $DEST_COC_EXTENSIONS.bak
    echo "$DEST_COC_EXTENSIONS directory exists. Moved it to $DEST_COC_EXTENSIONS.bak"
fi

if [ -f $DEST_COC_CONFIG_FILE ]; then
    mv $DEST_COC_CONFIG_FILE $DEST_COC_CONFIG_FILE.bak
    echo "$DEST_COC_CONFIG_FILE file exists. Moved it to $DEST_COC_CONFIG_FILE.bak"
fi

# Symlink coc files
ln -s $SRC_COC_CONFIG_FILE $DEST_COC_CONFIG_FILE
ln -s $SRC_COC_EXTENSIONS $DEST_COC_EXTENSIONS
echo "Success: Symlinked all the vim config files!"

# Install coc extensions
cd $SCRIPT_DIR/coc.vim/extensions
yarn
echo "Coc.vim extensions installed!"
