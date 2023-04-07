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
alias histreload='fc -R'
alias zshsource='source ~/.zshrc && histreload'

# bazel
alias bazel=bazelisk

# kubernetes
alias kctl="kubectx"
alias k="kubectl"

# lazygit
alias lgit="lazygit"

# macOS
if [[ `uname` == "Darwin" ]]; then
    FILE=$DOTFILES/zsh/alias_macos.zsh && [ -f $FILE ] && source "$FILE"
fi
