# go
export GOPATH=~/Development/go
export GOBIN=~/Development/go/bin
export PATH=$PATH:$GOPATH/bin

# git fuzzy
export PATH=$PATH:~/.zsh/git-fuzzy/bin

# yarn
export PATH="$PATH:$(yarn global bin)"

# arch linux
if type pacman > /dev/null; then
    source $DOTFILES/zsh/arch_export.zsh
fi

# ubuntu linux
if type apt > /dev/null; then
	source $DOTFILES/zsh/ubuntu_export.zsh
fi

# macOS
if [[ `uname` == "Darwin" ]]; then
    source $DOTFILES/zsh/macos_export.zsh
fi
