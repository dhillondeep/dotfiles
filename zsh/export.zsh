# go
export GOPATH=~/Development/go
export PATH=$PATH:$GOPATH/bin

# arch linux
if type pacman > /dev/null; then
    source $DOTFILES/zsh/arch_export.zsh
fi

# macOS
if [[ `uname` == "Darwin" ]]; then
    source $DOTFILES/zsh/macos_export.zsh
fi
