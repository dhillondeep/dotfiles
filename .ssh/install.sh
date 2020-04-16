#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
CONFIG="config"

# Symlink files
ln -s $SCRIPT_DIR/CONFIG ~/.ssh/$CONFIG
