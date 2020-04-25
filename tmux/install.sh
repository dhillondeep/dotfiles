#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
SRC_FILE="$SCRIPT_DIR/.tmux.conf"
DEST_FILE=~/.tmux.conf

if [ -d ~/.tmux/plugins/tpm ]; then
	mv ~/.tmux/plugins/tpm ~/.tmux/plugins/tpm.bak
	echo "Found ~/.tmux/plugins/tpm. Moved to ~/.tmux/plugins/tpm.bak"
fi

# install tmux plugin manage
git clone https://github.com/tmux-plugins/m ~/.tmux/plugins/tpm
echo "Success: Installed tmux package manager"

if [ -f $DEST_FILE ]; then
	mv $DEST_File $DEST_FILE.bak
    echo "Found $DEST_FILE. Moved to $DEST_FILE.bak"
fi

# symlink .zshrc file
ln -s $SRC_FILE $DEST_FILE
echo "Success: Symlinked $DEST_FILE file!"
