# for tmux 256 color support
export TERM="xterm-256color"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# set dotfiles location
export DOTFILES=~/.dotfiles

# ------------ Autocompletition -----------------
# -----------------------------------------------
# sourc completion plugin
source $DOTFILES/zsh/completion.zsh

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

# ------------ Autosuggestions ------------------
# -----------------------------------------------
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_USE_ASYNC=true

# ----------------- History ---------------------
# -----------------------------------------------
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

# specify keybindings
bindkey '^N' history-substring-search-up
bindkey '^P' history-substring-search-down

# configre the search
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=true
HISTORY_SUBSTRING_SEARCH_FUZZY=true
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=none,fg=none"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=none,fg=none"

# Source configuration files
source $DOTFILES/zsh/alias.zsh
source $DOTFILES/zsh/export.zsh
[ -f ~/.zshrc_local ] && source ~/.zshrc_local # local machine stuff

# fzf and ripgrep
export PATH=$PATH:~/.fzf/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_DEFAULT_OPS="--extended"

# setup starship
export STARSHIP_CONFIG=$DOTFILES/zsh/starship.toml
eval "$(starship init zsh)"

# ------------ Syntax Highlighting --------------
# -----------------------------------------------
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
