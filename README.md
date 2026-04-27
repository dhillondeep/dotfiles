# Dotfiles

Personal terminal, editor, and development environment configuration for macOS and Linux.

## How to use these dotfiles?

Clone the repo and run the bootstrap script:

```bash
git clone --depth=1 https://github.com/dhillondeep/dotfiles ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The default `shell` mode installs terminal essentials and links zsh, tmux, and Neovim config:

```bash
./install.sh shell
```

Use `full` mode on machines where you also want heavier development tools:

```bash
./install.sh full
```

Install only Neovim formatter/tooling dependencies:

```bash
./install.sh nvim-tools
```

Check a machine without changing it:

```bash
./install.sh check
```

Useful options:

```bash
./install.sh --link-only
./install.sh --no-packages
./install.sh --no-shell-change
./install.sh --dry-run
```

The bootstrap script detects macOS and Linux. On Linux it supports `apt`, `dnf`, and `pacman`, with Homebrew or portable installers for tools that are not consistently available in distro repositories. LazyVim requires Neovim `0.11.2` or newer; the script prefers Homebrew Neovim when available and falls back to an upstream portable build on Linux.

Homebrew users can audit the package set with:

```bash
brew bundle check --file Brewfile
```

### Available dotfiles
- `zsh`
- `tmux`
- `nvim`
- `atuin`
- `alacritty`

Machine-specific shell customizations should live in `~/.zshrc.local` or a private repo pointed to by `DOTFILES_PRIVATE`. See `examples/` for starter files.
