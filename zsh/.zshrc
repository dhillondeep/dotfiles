# for tmux 256 color support
export TERM="screen-256color"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# set dotfiles location
export DOTFILES=~/.dotfiles

# ------------ Syntax Highlighting --------------
# -----------------------------------------------
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

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

# Source configuration files
source ~/.dotfiles/zsh/alias.zsh
source ~/.dotfiles/zsh/export.zsh

# setup fzf and ripgrep
export PATH=$PATH:~/.fzf/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_DEFAULT_OPS="--extended"

# setup starship
export STARSHIP_CONFIG=$DOTFILES/zsh/starship.toml
eval "$(starship init zsh)"
