# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# set dotfiles location
export DOTFILES=${DOTFILES:-~/.dotfiles}
export DOTFILES_PRIVATE=${DOTFILES_PRIVATE:-~/.dotfiles.private}

# set local binaries location
export PATH=$PATH:~/.local/bin

# initialize the completion system
autoload -Uz compinit
if [[ -n ~/.zcompdump(N.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# setup zoxide
source ${DOTFILES}/zsh/zoxide.sh

# ------- History -------
# -----------------------

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

setopt extendedhistory incappendhistorytime
autoload -Uz add-zsh-hook

load-shared-history() {
  # Pop the current history off the history stack, so 
  # we don't grow the history stack endlessly
  fc -P

  # Load a new history from $HISTFILE and push
  # it onto the history stack.
  fc -p $HISTFILE
}

# Import the latest history at the start of each new 
# command line.
add-zsh-hook precmd load-shared-history

# ------- Plugins -------
# -----------------------

# - autocomplete -
zstyle ':autocomplete:*' fzf-completion yes
zstyle ':autocomplete:recent-dirs' backend zoxide
zstyle ':autocomplete:*' widget-style menu-select
source ${DOTFILES}/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# - syntax highlighting -
source ${DOTFILES}/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# - alias tips -
source ${DOTFILES}/zsh/plugins/alias-tips/alias-tips.plugin.zsh

# - vi mode -
export ZVM_INIT_MODE=sourcing
source ${DOTFILES}/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# --------- FZF ---------
# -----------------------
export PATH=$PATH:~/.fzf/bin
FILE=~/.fzf.zsh && [ -f "$FILE" ] && source "$FILE"

# ------ Starship (Prompt) -------
# --------------------------------

export STARSHIP_CONFIG=$DOTFILES/zsh/starship.toml
eval "$(starship init zsh)"

# ---------- Key Bindings ----------
# ----------------------------------

# reset history search key binding
bindkey '\e[A' up-line-or-history
bindkey '\eOA' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\eOB' down-line-or-history

# --------- Configurations ---------
# ----------------------------------

source $DOTFILES/zsh/alias.zsh
source $DOTFILES/zsh/export.zsh
FILE=$DOTFILES_PRIVATE/zsh/alias.zsh && [ -f $FILE ] && source "$FILE"
FILE=$DOTFILES_PRIVATE/zsh/export.zsh && [ -f $FILE ] && source "$FILE"
FILE=~/.zshrc.local && [ -f "$FILE" ] && source "$FILE" # local

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
