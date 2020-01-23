# dotfiles
These are my private configuration files. It has bunch of configurations for tools I use so feel free to look and use what you like.

## zsh
For zsh, I am using [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [powerlevel9k](https://github.com/Powerlevel9k/powerlevel9k). Follow the instructions to install them first and then use this `.zshrc` file! 
* Setup Instructions:
  * You need to get zsh shell first and for that [follow instructions here](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH#install-and-set-up-zsh-as-default).
  * Install [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
  * Install [powerlevel9k](https://github.com/Powerlevel9k/powerlevel9k)
  * If needed, install [powerline fonts](https://github.com/powerline/fonts)
  * Move or Symlink `zsh/.zshrc` to `~/.zshrc`
  * Install plugins using ohmyzsh:
    * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md#oh-my-zsh)
    * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh)
  * Source `~/.zshrc`
* All the secret tokens, sensitive information, and machine specific info goes inside `.zshrc_secret` file.

## vim
I am using [neovim](https://github.com/neovim/neovim) as my editor and `.zshrc` has an alias that maps `vim` command to `nvim`. In order to configure vim, I use [vimrc project](https://github.com/dhillondeep/vimrc). This project has an extensive amount of configurations that I have tuned to my needs!
* Setup instructions:
  * Move or Symlink `vim/.vimrc` to `~/.vimrc`
  * Move or Symlink `vim/vim_runtime/my_configs` to `~/.vim_runtime/my_configs`
  * Move or Symlink `vim/vim_runtime/my_plugins` to `~/.vim_runtime/my_plugins`
  * Move or Symlink `nvim/init.vim` to `~/.config/nvim/init.vim`
  * Follow [this instruction](https://github.com/junegunn/vim-plug#vim) to install vimplug
* For plugins, [vimplug](https://github.com/junegunn/vim-plug) is used
  * Modify `~/.vim_runtime/my_plugins.vim` file to add or remove plugins

## [kitty](https://github.com/kovidgoyal/kitty)
Kitty is a cross-platform, fast, feature full, GPU based terminal emulator. This is my default terminal!
* Setup instructions:
  * Install [kitty](https://github.com/kovidgoyal/kitty)
  * Move or Symlink `kitty/kitty.conf` to `~/.config/kitty/kitty.conf`
* Key binding:
  * Command + ` => to maximize/minimize terminal

## [hammerspoon](http://www.hammerspoon.org/)
Hammerspoon is a tool for powerful automation of OS X. My primarily use case for this is to have key binding for opening and closing kitty terminal from anywhere. Whenever key bindings are used, it opens the terminal at top or hides the terminal.
* Setup Instructions:
  * Install [Hammerspoon](http://www.hammerspoon.org/)
  * Move or Symlink `hammerspoon/init.lua` to `~/.hammerspoon/init.lua`
* Key binding:
  * Control + ` => to show/hide terminal
