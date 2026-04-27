#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/dhillondeep/dotfiles.git}"
TARGET_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
INSTALL_ARGS="${DOTFILES_INSTALL_ARGS:---no-shell-change}"
SKIP_UPDATE="${DOTFILES_SKIP_UPDATE:-0}"

log() {
  printf '\n==> %s\n' "$*"
}

sudo_cmd() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    printf 'WARN: sudo is required to install git on this system\n' >&2
    return 1
  fi
}

install_git() {
  if command -v git >/dev/null 2>&1; then
    return 0
  fi

  log "Installing git"
  if command -v brew >/dev/null 2>&1; then
    brew install git
  elif command -v apt-get >/dev/null 2>&1; then
    sudo_cmd apt-get update
    sudo_cmd apt-get install -y git
  elif command -v dnf >/dev/null 2>&1; then
    sudo_cmd dnf install -y git
  elif command -v pacman >/dev/null 2>&1; then
    sudo_cmd pacman -Syu --needed --noconfirm git
  else
    printf 'ERROR: git is missing and no supported package manager was found\n' >&2
    exit 1
  fi
}

install_git

if [ -d "$TARGET_DIR/.git" ]; then
  if [ "$SKIP_UPDATE" = "1" ]; then
    log "Using existing dotfiles checkout"
  else
    log "Updating dotfiles"
    git -C "$TARGET_DIR" pull --ff-only
  fi
else
  log "Cloning dotfiles"
  git clone "$REPO_URL" "$TARGET_DIR"
fi

log "Running install.sh $INSTALL_ARGS"
# shellcheck disable=SC2086
"$TARGET_DIR/install.sh" $INSTALL_ARGS
