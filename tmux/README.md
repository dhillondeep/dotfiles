# Tmux

## Setup
- Install Script
```bash
./install.sh
```
- `prefix` + <kbd>I</kbd> to install pluggins

## Configurations
### General Bindings
```
prefix + R source ~/.tmux.conf
prefix + M Use Mouse
prefix + m Disable Mouse
prefix + c Create new window in the same path
```

### Pane Management
#### Navigation

- `prefix + h` and `prefix + C-h`<br/>
  select pane on the left
- `prefix + j` and `prefix + C-j`<br/>
  select pane below the current one
- `prefix + k` and `prefix + C-k`<br/>
  select pane above
- `prefix + l` and `prefix + C-l`<br/>
  select pane on the right

These mappings are repeatable.

### Resizing panes

- `prefix + shift + h`<br/>
  resize current pane 5 cells to the left
- `prefix + shift + j`<br/>
  resize 5 cells in the down direction
- `prefix + shift + k`<br/>
  resize 5 cells in the up direction
- `prefix + shift + l`<br/>
  resize 5 cells to the right

These mappings are repeatable.

### Splitting panes

- `prefix + |`<br/>
  split current pane horizontally
- `prefix + -`<br/>
  split current pane vertically
- `prefix + \`<br/>
  split current pane full width horizontally
- `prefix + _`<br/>
  split current pane full width vertically

Newly created pane always has the same path as the original pane.

### Swapping windows

- `prefix + <` - moves current window one position to the left
- `prefix + >` - moves current window one position to the right

### Tmux Session Management

- `prefix + Ctrl-s` - save
- `prefix + Ctrl-r` - restore
