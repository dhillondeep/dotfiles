#!/bin/bash

# vim
printf "Setting up Ultimate Vim Configuration...\n"
git clone --depth=1 https://github.com/dhillondeep/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
ln -s $(pwd)/vim/vim_runtime/my_configs.vim ~/.vim_runtime/my_configs.vim
printf "Done!\n\n"

# tmux
printf "Setting up tmux.conf andd tpm...\n"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -s $(pwd)/tmux/.tmux.conf ~/.tmux.conf
printf "Done!\n"
