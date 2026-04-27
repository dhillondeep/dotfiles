#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-shell}"
STAMP="$(date +%Y%m%d%H%M%S)"

usage() {
  cat <<EOF
Usage: ./install.sh [shell|full]

Modes:
  shell  Install terminal essentials and link zsh/tmux/nvim configs. Default.
  full   Also install heavier development tools used by this dotfiles repo.
EOF
}

case "$MODE" in
  shell | --shell) MODE="shell" ;;
  full | --full | dev | --dev) MODE="full" ;;
  -h | --help) usage; exit 0 ;;
  *) usage; exit 1 ;;
esac

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

sudo_cmd() {
  if [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    warn "sudo is required for package installation on this system"
    return 1
  fi
}

link_path() {
  local source="$1"
  local target="$2"
  local parent
  parent="$(dirname "$target")"
  mkdir -p "$parent"

  if [ -L "$target" ]; then
    if [ "$(readlink "$target")" = "$source" ]; then
      printf 'linked: %s -> %s\n' "$target" "$source"
      return 0
    fi
    mv "$target" "$target.bak.$STAMP"
  elif [ -e "$target" ]; then
    mv "$target" "$target.bak.$STAMP"
  fi

  ln -s "$source" "$target"
  printf 'linked: %s -> %s\n' "$target" "$source"
}

install_macos() {
  if ! command -v brew >/dev/null 2>&1; then
    log "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  log "Installing macOS shell tools"
  brew install git zsh tmux neovim curl ca-certificates gnupg wget bat eza ripgrep fd zoxide fzf starship atuin go-task
  brew install --cask font-iosevka font-iosevka-nerd-font || true

  if [ "$MODE" = "full" ]; then
    log "Installing macOS development tools"
    brew install cmake ninja make go python yarn nvm bazelisk docker docker-compose kubernetes-cli kubectx k9s eksctl gh awscli
    brew install --cask gcloud-cli || true
  fi
}

install_linux_apt() {
  log "Installing Linux shell tools with apt"
  sudo_cmd apt-get update
  sudo_cmd apt-get install -y git zsh tmux neovim curl wget unzip ca-certificates gnupg bat ripgrep fd-find fzf

  mkdir -p "$HOME/.local/bin"
  command -v fdfind >/dev/null 2>&1 && ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"
  command -v batcat >/dev/null 2>&1 && ln -sfn "$(command -v batcat)" "$HOME/.local/bin/bat"

  if apt-cache show eza >/dev/null 2>&1; then
    sudo_cmd apt-get install -y eza
  else
    warn "eza is not available from this apt repository; install it separately if ls aliases need icons"
  fi

  if [ "$MODE" = "full" ]; then
    log "Installing Linux development tools with apt"
    sudo_cmd apt-get install -y build-essential cmake ninja-build make golang python3 python3-pip docker.io docker-compose
  fi
}

install_linux_dnf() {
  log "Installing Linux shell tools with dnf"
  sudo_cmd dnf install -y git zsh tmux neovim curl wget unzip ca-certificates gnupg bat ripgrep fd-find fzf eza

  if [ "$MODE" = "full" ]; then
    log "Installing Linux development tools with dnf"
    sudo_cmd dnf groupinstall -y "Development Tools" || true
    sudo_cmd dnf install -y cmake ninja-build make golang python3 python3-pip docker docker-compose
  fi
}

install_linux_pacman() {
  log "Installing Linux shell tools with pacman"
  sudo_cmd pacman -Syu --needed --noconfirm git zsh tmux neovim curl wget unzip ca-certificates gnupg bat ripgrep fd fzf eza

  if [ "$MODE" = "full" ]; then
    log "Installing Linux development tools with pacman"
    sudo_cmd pacman -S --needed --noconfirm base-devel cmake ninja make go python python-pip docker docker-compose
  fi
}

install_linux_brew_tools() {
  log "Installing cross-platform tools with Homebrew"
  brew install neovim zoxide starship atuin go-task
}

install_linux_portable_tools() {
  mkdir -p "$HOME/.local/bin"

  if ! command -v zoxide >/dev/null 2>&1; then
    log "Installing zoxide"
    curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi

  if ! command -v starship >/dev/null 2>&1; then
    log "Installing starship"
    curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
  fi

  if ! command -v atuin >/dev/null 2>&1; then
    log "Installing atuin"
    curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
  fi
}

install_linux() {
  if command -v apt-get >/dev/null 2>&1; then
    install_linux_apt
  elif command -v dnf >/dev/null 2>&1; then
    install_linux_dnf
  elif command -v pacman >/dev/null 2>&1; then
    install_linux_pacman
  else
    warn "No supported Linux package manager found; skipping system packages"
  fi

  if command -v brew >/dev/null 2>&1; then
    install_linux_brew_tools
  else
    install_linux_portable_tools
  fi
}

repair_neovim_shim() {
  if ! command -v brew >/dev/null 2>&1; then
    return 0
  fi

  local brew_nvim
  brew_nvim="$(brew --prefix)/bin/nvim"
  if [ ! -x "$brew_nvim" ]; then
    return 0
  fi

  mkdir -p "$HOME/.local/bin"
  ln -sfn "$brew_nvim" "$HOME/.local/bin/nvim"
  printf 'linked: %s -> %s\n' "$HOME/.local/bin/nvim" "$brew_nvim"
}

check_neovim_version() {
  if ! command -v nvim >/dev/null 2>&1; then
    warn "Neovim is not installed; LazyVim config will not work until nvim is available"
    return 0
  fi

  local version
  version="$(nvim --version | awk 'NR == 1 { sub(/^NVIM v/, "", $2); print $2 }')"
  if ! awk -v version="$version" 'BEGIN {
    split(version, found, ".")
    split("0.11.2", want, ".")
    for (i = 1; i <= 3; i++) {
      found[i] += 0
      want[i] += 0
      if (found[i] > want[i]) exit 0
      if (found[i] < want[i]) exit 1
    }
    exit 0
  }'; then
    warn "LazyVim requires Neovim >= 0.11.2; found $version at $(command -v nvim)"
  fi
}

link_dotfiles() {
  log "Linking dotfiles"
  link_path "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
  link_path "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
  link_path "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
}

install_submodules() {
  if [ -f "$DOTFILES_DIR/.gitmodules" ] && command -v git >/dev/null 2>&1; then
    log "Installing dotfiles submodules"
    git -C "$DOTFILES_DIR" submodule update --init --recursive
  fi
}

install_tpm() {
  log "Installing tmux plugin manager"
  mkdir -p "$HOME/.tmux/plugins"
  if [ -d "$HOME/.tmux/plugins/tpm/.git" ]; then
    git -C "$HOME/.tmux/plugins/tpm" pull --ff-only || warn "Could not update TPM"
  else
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi

  if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" || warn "Could not install tmux plugins"
  fi
}

set_zsh_shell() {
  if command -v zsh >/dev/null 2>&1 && [ "${SHELL:-}" != "$(command -v zsh)" ]; then
    log "Setting zsh as the default shell"
    chsh -s "$(command -v zsh)" "${USER:-}" || warn "Could not change default shell; run chsh manually"
  fi
}

case "$(uname -s)" in
  Darwin) install_macos ;;
  Linux) install_linux ;;
  *) warn "Unsupported OS: $(uname -s); linking dotfiles only" ;;
esac

repair_neovim_shim
check_neovim_version
install_submodules
link_dotfiles
install_tpm
set_zsh_shell

log "Done. Open a new terminal or run: exec zsh"
