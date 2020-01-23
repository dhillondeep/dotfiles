#!/bin/bash

# vim
printf "Setting up Ultimate Vim Configuration...\n"
git clone --depth=1 https://github.com/dhillondeep/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
ln -s $(pwd)/vim/vim_runtime/my_configs.vim ~/.vim_runtime/my_configs.vim
ln -s $(pwd)/vim/nvim/init.vim ~/.config/nvim/init.vim
printf "Done!\n\n"

# tmux
printf "Setting up tmux.conf and tpm...\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $(pwd)/tmux/.tmux.conf ~/.tmux.conf
printf "Done!\n\n"

# kitty
printf "Setting up kitty.conf...\n"
mkdir -p ~/.config/kitty
ln -s $(pwd)/kitty/kitty.conf ~/.config/kitty/kitty.conf
printf "Done!\n\n"

# hammerspoon
printf "Setting up hammerspoon's init.lua...\n"
mkdir -p ~/.hammerspoon
ln -s $(pwd)/hammerspoon/init.lua ~/.hammerspoon/init.lua
printf "Done!\n\n"

# zsh
printf "Setting up .zshrc...\n"
ln -s $(pwd)/zsh/.zshrc ~/.zshrc
printf "Done!\n"
