# -- tmux --
alias ta="tmux attach -t"
alias tn="tmux new -t"
alias tl="tmux list-sessions"
alias tap="tmux attach -t personal || tmux new -t personal"

# -- vim --
alias vim="nvim"
alias svim="sudoedit nvim"

# -- faster tools --
command -v bat >/dev/null 2>&1 && alias cat=bat
command -v rg >/dev/null 2>&1 && alias grep=rg
command -v fd >/dev/null 2>&1 && alias find=fd

if command -v eza >/dev/null 2>&1; then
	alias ls=eza
	alias ll='eza -lah --icons --group-directories-first'
else
	alias ll='ls -lah'
fi

# -- zsh --
alias histreload='fc -R'
alias zshsource='source ~/.zshrc && histreload'

# bazel
alias bazel=bazelisk

# kubernetes
alias kctl="kubectx"
#alias k="kubectl"

# lazygit
alias lgit="lazygit"

# macOS
if [[ `uname` == "Darwin" ]]; then
    FILE=$DOTFILES/zsh/alias_macos.zsh && [ -f $FILE ] && source "$FILE"
fi
