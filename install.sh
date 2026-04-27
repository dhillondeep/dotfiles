#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
MODE="shell"
STAMP="$(date +%Y%m%d%H%M%S)"
INSTALL_PACKAGES=1
LINK_DOTFILES=1
CHANGE_SHELL=1
INSTALL_PLUGINS=1
DRY_RUN=0
CHECK_FAILED=0

APT_SHELL_PACKAGES=(git zsh tmux neovim curl wget unzip ca-certificates gnupg bat ripgrep fd-find fzf)
DNF_SHELL_PACKAGES=(git zsh tmux neovim curl wget unzip ca-certificates gnupg bat ripgrep fd-find fzf eza)
PACMAN_SHELL_PACKAGES=(git zsh tmux neovim curl wget unzip ca-certificates gnupg bat ripgrep fd fzf eza mise uv git-delta lazygit)

APT_FULL_PACKAGES=(build-essential cmake ninja-build make golang python3 python3-pip docker.io docker-compose)
DNF_FULL_PACKAGES=(cmake ninja-build make golang python3 python3-pip docker docker-compose)
PACMAN_FULL_PACKAGES=(base-devel cmake ninja make go python python-pip docker docker-compose)

NVIM_MIN_VERSION="0.11.2"

usage() {
  cat <<EOF
Usage: ./install.sh [shell|full|nvim-tools|check] [options]

Modes:
  shell       Install terminal essentials and link configs. Default.
  full        Install shell tools plus heavier development tools.
  nvim-tools  Install formatter/tooling dependencies used by Neovim.
  check       Report missing tools, broken links, and version problems.

Options:
  --link-only        Only link dotfiles; skip package installs and shell change.
  --no-packages      Skip package installation.
  --no-shell-change  Do not run chsh.
  --dry-run          Print mutating commands instead of running them.
  -h, --help         Show this help.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    shell | full | nvim-tools | check) MODE="$1" ;;
    --shell) MODE="shell" ;;
    --full | dev | --dev) MODE="full" ;;
    --link-only) INSTALL_PACKAGES=0; CHANGE_SHELL=0; INSTALL_PLUGINS=0 ;;
    --no-packages) INSTALL_PACKAGES=0 ;;
    --no-shell-change) CHANGE_SHELL=0 ;;
    --dry-run) DRY_RUN=1 ;;
    -h | --help) usage; exit 0 ;;
    *) usage; exit 1 ;;
  esac
  shift
done

if [ "$MODE" = "check" ]; then
  INSTALL_PACKAGES=0
  LINK_DOTFILES=0
  CHANGE_SHELL=0
  INSTALL_PLUGINS=0
fi

if [ "$MODE" = "nvim-tools" ]; then
  LINK_DOTFILES=0
  CHANGE_SHELL=0
  INSTALL_PLUGINS=0
fi

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf 'WARN: %s\n' "$*" >&2
}

run() {
  if [ "$DRY_RUN" -eq 1 ]; then
    printf 'DRY RUN:'
    printf ' %q' "$@"
    printf '\n'
  else
    "$@"
  fi
}

sudo_cmd() {
  if [ "$DRY_RUN" -eq 1 ]; then
    printf 'DRY RUN:'
    if [ "$(id -u)" -ne 0 ] && command -v sudo >/dev/null 2>&1; then
      printf ' sudo'
    fi
    printf ' %q' "$@"
    printf '\n'
  elif [ "$(id -u)" -eq 0 ]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    warn "sudo is required for package installation on this system"
    return 1
  fi
}

check_ok() {
  printf 'ok: %s\n' "$*"
}

check_warn() {
  CHECK_FAILED=1
  warn "$*"
}

same_link_target() {
  local current="${1%/}"
  local expected="${2%/}"
  [ "$current" = "$expected" ]
}

version_at_least() {
  local found="$1"
  local want="$2"
  awk -v found="$found" -v want="$want" 'BEGIN {
    split(found, f, ".")
    split(want, w, ".")
    for (i = 1; i <= 3; i++) {
      f[i] += 0
      w[i] += 0
      if (f[i] > w[i]) exit 0
      if (f[i] < w[i]) exit 1
    }
    exit 0
  }'
}

nvim_version() {
  command -v nvim >/dev/null 2>&1 || return 1
  nvim --version | awk 'NR == 1 { sub(/^NVIM v/, "", $2); print $2 }'
}

nvim_meets_min_version() {
  local version
  version="$(nvim_version)" || return 1
  version_at_least "$version" "$NVIM_MIN_VERSION"
}

link_path() {
  local source="$1"
  local target="$2"
  local parent
  parent="$(dirname "$target")"
  run mkdir -p "$parent"

  if [ -L "$target" ]; then
    if same_link_target "$(readlink "$target")" "$source"; then
      printf 'linked: %s -> %s\n' "$target" "$source"
      return 0
    fi
    run mv "$target" "$target.bak.$STAMP"
  elif [ -e "$target" ]; then
    run mv "$target" "$target.bak.$STAMP"
  fi

  run ln -s "$source" "$target"
  printf 'linked: %s -> %s\n' "$target" "$source"
}

brew_install() {
  if [ "$#" -gt 0 ]; then
    run brew install "$@"
  fi
}

brew_bundle() {
  local brewfile="$1"
  if [ -f "$brewfile" ]; then
    run brew bundle --file "$brewfile"
  fi
}

install_macos() {
  if [ "$INSTALL_PACKAGES" -eq 0 ]; then
    return 0
  fi

  if ! command -v brew >/dev/null 2>&1; then
    log "Installing Homebrew"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf 'DRY RUN: install Homebrew\n'
    else
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi

  log "Installing macOS shell tools"
  brew_bundle "$DOTFILES_DIR/Brewfile"
  brew_bundle "$DOTFILES_DIR/Brewfile.macos"

  if [ "$MODE" = "full" ]; then
    log "Installing macOS development tools"
    brew_bundle "$DOTFILES_DIR/Brewfile.full"
    brew_bundle "$DOTFILES_DIR/Brewfile.full.macos"
  fi
}

install_linux_apt() {
  [ "$INSTALL_PACKAGES" -eq 1 ] || return 0

  log "Installing Linux shell tools with apt"
  sudo_cmd apt-get update
  sudo_cmd apt-get install -y "${APT_SHELL_PACKAGES[@]}"

  run mkdir -p "$HOME/.local/bin"
  if command -v fdfind >/dev/null 2>&1; then
    run ln -sfn "$(command -v fdfind)" "$HOME/.local/bin/fd"
  fi
  if command -v batcat >/dev/null 2>&1; then
    run ln -sfn "$(command -v batcat)" "$HOME/.local/bin/bat"
  fi

  if apt-cache show eza >/dev/null 2>&1; then
    sudo_cmd apt-get install -y eza
  else
    warn "eza is not available from this apt repository; install it separately if ls aliases need icons"
  fi

  if [ "$MODE" = "full" ]; then
    log "Installing Linux development tools with apt"
    sudo_cmd apt-get install -y "${APT_FULL_PACKAGES[@]}"
  fi
}

install_linux_dnf() {
  [ "$INSTALL_PACKAGES" -eq 1 ] || return 0

  log "Installing Linux shell tools with dnf"
  sudo_cmd dnf install -y "${DNF_SHELL_PACKAGES[@]}"

  if [ "$MODE" = "full" ]; then
    log "Installing Linux development tools with dnf"
    sudo_cmd dnf groupinstall -y "Development Tools" || true
    sudo_cmd dnf install -y "${DNF_FULL_PACKAGES[@]}"
  fi
}

install_linux_pacman() {
  [ "$INSTALL_PACKAGES" -eq 1 ] || return 0

  log "Installing Linux shell tools with pacman"
  sudo_cmd pacman -Syu --needed --noconfirm "${PACMAN_SHELL_PACKAGES[@]}"

  if [ "$MODE" = "full" ]; then
    log "Installing Linux development tools with pacman"
    sudo_cmd pacman -S --needed --noconfirm "${PACMAN_FULL_PACKAGES[@]}"
  fi
}

install_linux_brew_tools() {
  [ "$INSTALL_PACKAGES" -eq 1 ] || return 0

  log "Installing cross-platform tools with Homebrew"
  brew_bundle "$DOTFILES_DIR/Brewfile"
}

install_linux_portable_tools() {
  [ "$INSTALL_PACKAGES" -eq 1 ] || return 0

  run mkdir -p "$HOME/.local/bin"

  if ! command -v zoxide >/dev/null 2>&1; then
    log "Installing zoxide"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf 'DRY RUN: install zoxide via upstream script\n'
    else
      curl -fsSL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    fi
  fi

  if ! command -v starship >/dev/null 2>&1; then
    log "Installing starship"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf 'DRY RUN: install starship via upstream script\n'
    else
      curl -fsSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
    fi
  fi

  if ! command -v atuin >/dev/null 2>&1; then
    log "Installing atuin"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf 'DRY RUN: install atuin via upstream script\n'
    else
      curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
    fi
  fi

  if ! command -v mise >/dev/null 2>&1; then
    log "Installing mise"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf 'DRY RUN: install mise via upstream script\n'
    else
      curl https://mise.run | sh
    fi
  fi

  if ! command -v uv >/dev/null 2>&1; then
    log "Installing uv"
    if [ "$DRY_RUN" -eq 1 ]; then
      printf 'DRY RUN: install uv via upstream script\n'
    else
      curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
    fi
  fi
}

install_neovim_portable() {
  [ "$INSTALL_PACKAGES" -eq 1 ] || return 0

  local arch url tmpdir install_root extract_name
  case "$(uname -m)" in
    x86_64 | amd64) arch="x86_64" ;;
    arm64 | aarch64) arch="arm64" ;;
    *) warn "Unsupported architecture for portable Neovim: $(uname -m)"; return 0 ;;
  esac

  extract_name="nvim-linux-$arch"
  install_root="$HOME/.local/opt"
  url="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION:-stable}/${extract_name}.tar.gz"

  log "Installing portable Neovim from $url"
  if [ "$DRY_RUN" -eq 1 ]; then
    printf 'DRY RUN: download and install portable Neovim to %s/%s\n' "$install_root" "$extract_name"
    return 0
  fi

  tmpdir="$(mktemp -d)"
  curl -fsSL "$url" -o "$tmpdir/nvim.tar.gz"
  mkdir -p "$install_root" "$HOME/.local/bin"
  tar -xzf "$tmpdir/nvim.tar.gz" -C "$install_root"
  ln -sfn "$install_root/$extract_name/bin/nvim" "$HOME/.local/bin/nvim"
  rm -rf "$tmpdir"
}

ensure_linux_neovim() {
  [ "$(uname -s)" = "Linux" ] || return 0
  if nvim_meets_min_version; then
    return 0
  fi

  if command -v brew >/dev/null 2>&1; then
    install_linux_brew_tools
  fi

  if ! nvim_meets_min_version; then
    install_neovim_portable
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

  ensure_linux_neovim
}

install_nvim_tools() {
  [ "$INSTALL_PACKAGES" -eq 1 ] || return 0

  log "Installing Neovim formatter tools"
  if command -v brew >/dev/null 2>&1; then
    brew_bundle "$DOTFILES_DIR/Brewfile.nvim"
    return 0
  fi

  if command -v go >/dev/null 2>&1; then
    run go install mvdan.cc/gofumpt@latest
    run go install golang.org/x/tools/cmd/goimports@latest
    run go install github.com/segmentio/golines@latest
  else
    warn "go is not installed; skipping gofumpt, goimports, and golines"
  fi

  if command -v uv >/dev/null 2>&1; then
    run uv tool install ruff
  elif command -v pipx >/dev/null 2>&1; then
    run pipx install ruff
  elif command -v python3 >/dev/null 2>&1; then
    run python3 -m pip install --user ruff
  else
    warn "python3, uv, or pipx is required to install ruff"
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

  run mkdir -p "$HOME/.local/bin"
  run ln -sfn "$brew_nvim" "$HOME/.local/bin/nvim"
  printf 'linked: %s -> %s\n' "$HOME/.local/bin/nvim" "$brew_nvim"
}

check_neovim_version() {
  local version
  if ! version="$(nvim_version)"; then
    warn "Neovim is not installed; LazyVim config will not work until nvim is available"
    return 0
  fi

  if ! version_at_least "$version" "$NVIM_MIN_VERSION"; then
    warn "LazyVim requires Neovim >= $NVIM_MIN_VERSION; found $version at $(command -v nvim)"
  fi
}

link_dotfiles() {
  [ "$LINK_DOTFILES" -eq 1 ] || return 0

  log "Linking dotfiles"
  link_path "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
  link_path "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
  link_path "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
  link_path "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
  link_path "$DOTFILES_DIR/atuin/config.toml" "$HOME/.config/atuin/config.toml"
  link_path "$DOTFILES_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
  link_path "$DOTFILES_DIR/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"
  link_path "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

  case "$(uname -s)" in
    Darwin) link_path "$DOTFILES_DIR/alacritty/macos/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml" ;;
    Linux) link_path "$DOTFILES_DIR/alacritty/linux/alacritty.yml" "$HOME/.config/alacritty/alacritty.yml" ;;
  esac
}

install_submodules() {
  [ "$INSTALL_PLUGINS" -eq 1 ] || return 0

  if [ -f "$DOTFILES_DIR/.gitmodules" ] && command -v git >/dev/null 2>&1; then
    log "Installing dotfiles submodules"
    run git -C "$DOTFILES_DIR" submodule update --init --recursive
  fi
}

install_tpm() {
  [ "$INSTALL_PLUGINS" -eq 1 ] || return 0

  log "Installing tmux plugin manager"
  run mkdir -p "$HOME/.tmux/plugins"
  if [ -d "$HOME/.tmux/plugins/tpm/.git" ]; then
    run git -C "$HOME/.tmux/plugins/tpm" pull --ff-only || warn "Could not update TPM"
  else
    run git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi

  if [ -x "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]; then
    run "$HOME/.tmux/plugins/tpm/bin/install_plugins" || warn "Could not install tmux plugins"
  fi
}

set_zsh_shell() {
  [ "$CHANGE_SHELL" -eq 1 ] || return 0

  if command -v zsh >/dev/null 2>&1 && [ "${SHELL:-}" != "$(command -v zsh)" ]; then
    log "Setting zsh as the default shell"
    run chsh -s "$(command -v zsh)" "${USER:-}" || warn "Could not change default shell; run chsh manually"
  fi
}

check_command() {
  if command -v "$1" >/dev/null 2>&1; then
    check_ok "$1 -> $(command -v "$1")"
  else
    check_warn "$1 is missing"
  fi
}

check_ghostty() {
  if command -v ghostty >/dev/null 2>&1; then
    check_ok "ghostty -> $(command -v ghostty)"
  elif [ -d "/Applications/Ghostty.app" ]; then
    check_ok "Ghostty.app is installed"
  else
    check_warn "Ghostty is missing"
  fi
}

check_link() {
  local target="$1"
  local expected="$2"
  if [ -L "$target" ] && same_link_target "$(readlink "$target")" "$expected"; then
    check_ok "$target -> $expected"
  else
    check_warn "$target is not linked to $expected"
  fi
}

check_submodules() {
  if [ ! -f "$DOTFILES_DIR/.gitmodules" ]; then
    return 0
  fi

  local status
  status="$(git -C "$DOTFILES_DIR" submodule status --recursive || true)"
  if printf '%s\n' "$status" | awk 'substr($0, 1, 1) ~ /[-+]/ { found = 1 } END { exit found ? 0 : 1 }'; then
    check_warn "one or more git submodules are missing or out of sync"
    printf '%s\n' "$status"
  else
    check_ok "git submodules are initialized"
  fi
}

check_neovim_health() {
  local version
  if ! version="$(nvim_version)"; then
    check_warn "nvim is missing"
    return 0
  fi

  if version_at_least "$version" "$NVIM_MIN_VERSION"; then
    check_ok "nvim $version"
  else
    check_warn "nvim $version is older than required $NVIM_MIN_VERSION"
  fi

  if nvim --headless '+lua print("nvim-ok")' +qa >/dev/null 2>&1; then
    check_ok "Neovim starts headlessly"
  else
    check_warn "Neovim headless startup failed"
  fi
}

check_dotfiles() {
  log "Checking dotfiles"

  for cmd in git zsh tmux nvim atuin starship zoxide fzf eza bat rg fd mise uv delta lazygit; do
    check_command "$cmd"
  done
  if [ "$(uname -s)" = "Darwin" ]; then
    check_ghostty
  fi

  check_link "$HOME/.gitconfig" "$DOTFILES_DIR/git/.gitconfig"
  check_link "$HOME/.zshrc" "$DOTFILES_DIR/zsh/.zshrc"
  check_link "$HOME/.tmux.conf" "$DOTFILES_DIR/tmux/.tmux.conf"
  check_link "$HOME/.config/nvim" "$DOTFILES_DIR/nvim"
  check_link "$HOME/.config/atuin/config.toml" "$DOTFILES_DIR/atuin/config.toml"
  check_link "$HOME/.config/mise/config.toml" "$DOTFILES_DIR/mise/config.toml"
  check_link "$HOME/.config/lazygit/config.yml" "$DOTFILES_DIR/lazygit/config.yml"
  check_link "$HOME/.config/ghostty/config" "$DOTFILES_DIR/ghostty/config"

  case "$(uname -s)" in
    Darwin) check_link "$HOME/.config/alacritty/alacritty.yml" "$DOTFILES_DIR/alacritty/macos/alacritty.yml" ;;
    Linux) check_link "$HOME/.config/alacritty/alacritty.yml" "$DOTFILES_DIR/alacritty/linux/alacritty.yml" ;;
  esac

  if zsh -n "$DOTFILES_DIR/zsh/.zshrc"; then
    check_ok "zsh config parses"
  else
    check_warn "zsh config has parse errors"
  fi

  check_neovim_health
  check_submodules

  if [ -d "$HOME/.tmux/plugins/tpm/.git" ]; then
    check_ok "tmux plugin manager is installed"
  else
    check_warn "tmux plugin manager is missing"
  fi

  return "$CHECK_FAILED"
}

if [ "$MODE" = "check" ]; then
  check_dotfiles
  exit "$?"
fi

if [ "$MODE" = "nvim-tools" ]; then
  install_nvim_tools
  exit 0
fi

case "$(uname -s)" in
  Darwin) install_macos ;;
  Linux) install_linux ;;
  *) warn "Unsupported OS: $(uname -s); linking dotfiles only" ;;
esac

if [ "$MODE" = "nvim-tools" ] || [ "$MODE" = "full" ]; then
  install_nvim_tools
fi

repair_neovim_shim
check_neovim_version
install_submodules
link_dotfiles
install_tpm
set_zsh_shell

log "Done. Open a new terminal or run: exec zsh"
