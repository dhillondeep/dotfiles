#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_FILE="$SCRIPT_DIR/.zshrc"
DEST_FILE=~/.zshrc

if [ -f $DEST_FILE ]; then
    mv $DEST_FILE $DEST_FILE.bak
    echo "Found $DEST_FILE. Move the file to $DEST_FILE.bak!"
fi

# Symlink .zshrc file
ln -s $SRC_FILE $DEST_FILE
echo "Success: Symlinked ~/.zshrc file!"

# clone zsh plugins
CLONE_DIR=~/.zsh/zsh-autosuggestions
if [ ! -d $CLONE_DIR ]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions $CLONE_DIR
fi

CLONE_DIR=~/.zsh/fast-syntax-highlighting
if [ ! -d $CLONE_DIR ]; then
	git clone https://github.com/zdharma/fast-syntax-highlighting $CLONE_DIR
fi

CLONE_DIR=~/.zsh/zsh-history-substring-search
if [ ! -d $CLONE_DIR ]; then
	git clone https://github.com/zsh-users/zsh-history-substring-search $CLONE_DIR
fi
echo "Success: zsh plugins downloaded!"

# clone tools
CLONE_DIR=~/.zsh/git-fuzzy
if [ ! -d $CLONE_DIR ]; then
	git clone https://github.com/bigH/git-fuzzy.git $CLONE_DIR
fi
echo "Success: downloaded tools required!"

# make zsh default shell
chsh -s $(which zsh)
echo "Zsh default shell!"
