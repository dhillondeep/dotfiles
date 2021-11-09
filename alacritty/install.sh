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

# Symlink alacritty.yml file
ln -s $SRC_FILE $DEST_FILE
echo "Success: Symlinked $DEST_FILE file!"

# Install font
brew tap homebrew/cask-fonts
brew install --cask font-iosevka-nerd-font font-iosevka
echo "Success: Iosevka Fonts Installed."
