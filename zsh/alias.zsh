# -- tmux --
alias ta="tmux attach -t"
alias tn="tmux new -t"
alias tl="tmux list-sessions"
alias tap="tmux attach -t personal || tmux new -t personal"

# -- vim --
alias vim="nvim"
alias svim="sudoedit nvim"

# -- faster tools --
alias cat=bat
alias grep=rg
alias find=fd
alias ls=exa

# -- zsh --
alias zshreload='source ~/.zshrc'

# bazel
alias bazel=bazelisk

# kubernetes
alias kctl="kubectx"
alias k="kubectl"

# macOS
if [[ `uname` == "Darwin" ]]; then
    source $DOTFILES/zsh/alias_macos.zsh
    source $DOTFILES_PRIVATE/zsh/alias_macos.zsh
fi
