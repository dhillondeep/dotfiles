#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_FILE="$SCRIPT_DIR/.zshrc"
DEST_FILE=~/.zshrc

if [ -f $DEST_FILE ]; then
    echo "Error: Cannot link because $DEST_FILE exists."
    exit 1
fi

# Symlink .zshrc file
ln -s $SRC_FILE $DEST_FILE
echo "Success: Symlinked ~/.zshrc file!"

# clone Oh-My-Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/olets/zsh-abbr.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-abbr

echo "Success: Installed Oh-My-Zsh plugins!"
