# Set preferred editor as Neovim
export EDITOR='nvim'

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

# Generated for nvm. Do not edit.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
gcloud_file_path="~/Lab/apps/gcloud-cli/path.zsh.inc"
eval gcloud_file_path=$gcloud_file_path
if [ -f $gcloud_file_path ]; then . $gcloud_file_path; fi

# The next line enables shell command completion for gcloud.
gcloud_comp_path="~/Lab/apps/gcloud-cli/completion.zsh.inc"
eval gcloud_comp_path=$gcloud_comp_path
if [ -f $gcloud_comp_path ]; then . $gcloud_comp_path; fi
