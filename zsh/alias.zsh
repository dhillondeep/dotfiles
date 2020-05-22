# tmux alias
alias ta="tmux attach -t"
alias tn="tmux new -t"
alias tl="tmux list-sessions"
alias tap="tmux attach -t personal || tmux new -t personal"

# vim
alias vim="nvim"
alias svim="sudoedit nvim"

# use pip as user
alias pipi="pip install --user"

# faster tools
alias cat=bat
alias grep=rg
alias find=fd
alias ls=exa

# zsh
alias zshreload='source ~/.zshrc'


# arch linux
if type pacman > /dev/null; then
    source $DOTFILES/zsh/arch_alias.zsh
fi

# macOS
if [[ `uname` == "Darwin" ]]; then
    source $DOTFILES/zsh/macos_alias.zsh
fi
