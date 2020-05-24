#!/bin/sh

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

# Install Starship
curl -fsSL https://starship.rs/install.sh | bash
echo "Success: Startship downloaded!"

# clone zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zdharma/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
echo "Success: zsh plugins downloaded!"
