# -- go --
export GOPATH=~/Lab/dev/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# -- bat --
export BAT_ARGS="--style=numbers --color=always"

# -- fd --
export FD_OPTS='--color=never --type f --hidden --follow --exclude .git'

# -- rg --
export RG_OPTS="--color=always --column --hidden --no-heading --follow --smart-case -g '!.git'"

# -- fzf --
export FZF_DEFAULT_COMMAND="fd $FD_OPTS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--info=inline "`
                        `"--layout=reverse "`
                        `"--ansi "`
                        `"--color='pointer:129,marker:010' "`
                        `"--height='40%' "`
                        `"--preview-window=:hidden "`
                        `"--preview '([[ -f {} ]] && (bat $BAT_ARGS {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' "`
                        `"--bind 'ctrl-r:toggle-all' "`
                        `"--bind 'ctrl-s:toggle-sort' "`
                        `"--bind '?:toggle-preview' "`
                        `"--bind 'ctrl-a:select-all'"

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    cmd="fd $FD_OPTS --type d . $1"
    eval $cmd
}
# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
_fzf_compgen_path() {
    cmd="fd $FD_OPTS . $1"
    eval $cmd
}

# -- zeoxide --
export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS"

# macOS
if [[ `uname` == "Darwin" ]]; then
    FILE=$DOTFILES/zsh/export_macos.zsh && [ -f $FILE ] && source "$FILE"
fi
