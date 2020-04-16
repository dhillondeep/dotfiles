#!/bin/sh

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
KWINRC="kwinrc"
KWINRULESRC="kwinrulesrc"
KWRITERC="kwriterc"
KDED5RC="kded5rc"
KDEGLOBALS="kdeglobals"
KHOTKEYSRC="khotkeysrc"

# Symlink files
ln -s $SCRIPT_DIR/$KWINRC ~/.config/$KWINRC
ln -s $SCRIPT_DIR/$KWINRULESRC ~/.config/$KWINRULESRC
ln -s $SCRIPT_DIR/$KWRITERC ~/.config/$KWRITERC
ln -s $SCRIPT_DIR/$KDED5RC ~/.config/$KDED5RC
ln -s $SCRIPT_DIR/$KDEGLOBALS ~/.config/$KDEGLOBALS
ln -s $SCRIPT_DIR/$KHOTKEYSRC ~/.config/$KHOTKEYSRC
