# dotfiles
These are my private configuration files. It has bunch of configurations for tools I use so feel free to look and use what you like.

## zsh
For zsh, I am using [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) and [powerlevel9k](https://github.com/Powerlevel9k/powerlevel9k). Follow the instructions to install them first and then use this `.zshrc` file! 
* All the secret tokens and sensitive information goes inside `.zshrc_secret` file.

## kitty and hammerspoon
For macOs, the combination of kitty and hammerspoon provides key binding to open the terminal from anywhere and then use the same key binding to show, and hide the terminal.
* Install [kitty](https://github.com/kovidgoyal/kitty)
* Install [Hammerspoon](http://www.hammerspoon.org/)
* Use `kitty/kitty.conf` as required configuration for kitty
* Use `hammerspoon/init.lua` as required configuration for hammerspoon
* Key binding:
  * Command + ` => to maximize/minimize terminal
  * Control + ` => to show/hide terminal
