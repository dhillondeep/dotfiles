# Private Dotfiles

Set `DOTFILES_PRIVATE` to a clone of a private repo when a machine needs
private aliases, exports, credentials helpers, or work-specific functions.

The shared `.zshrc` will source these files when they exist:

- `$DOTFILES_PRIVATE/zsh/export.zsh`
- `$DOTFILES_PRIVATE/zsh/alias.zsh`

Suggested layout:

```text
~/.dotfiles.private/
  zsh/
    export.zsh
    alias.zsh
```

Keep secrets out of Git whenever possible. Prefer password managers,
keychains, `aws-vault`, `op`, or environment managers for actual credentials.
