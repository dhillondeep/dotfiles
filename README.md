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

The bootstrap script detects macOS and Linux. On Linux it supports `apt`, `dnf`, and `pacman`, with Homebrew or portable installers for tools that are not consistently available in distro repositories.

### Available dotfiles
- `zsh`
- `tmux`
- `nvim`
- `alacritty`
