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
HISTSIZE=1000000
SAVEHIST=1000000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Append to the history.
setopt appendhistory
# Use the extended history format, which gives timing info.
setopt extendedhistory
# Append to the history after each command runs, including timing info.
setopt incappendhistorytime
# Do not store adjacent duplicate commands.
setopt histignoredups
# Remove superfluous blanks that sometimes make it into my commands.
setopt histreduceblanks
# Commands beginning with a space are forgotten.
setopt histignorespace
# Notify on the completion of background tasks as soon as they finish, instead
# of waiting for the next prompt.
setopt notify
# Don't remove trailing slashs from directory names.
setopt noautoremoveslash
# When completing an unambiguous prefix, show the completions immediately.
setopt nolistambiguous
# Permit completion to happen inside a word, just before the cursor.
setopt completeinword

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
export ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
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

bindkey "\e[A" history-beginning-search-backward
bindkey "\eOA" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
bindkey "\eOB" history-beginning-search-forward

bindkey -M vicmd "\e[A" history-beginning-search-backward
bindkey -M vicmd "\eOA" history-beginning-search-backward
bindkey -M vicmd "\e[B" history-beginning-search-backward
bindkey -M vicmd "\eOB" history-beginning-search-backward

# --------- Configurations ---------
# ----------------------------------

source $DOTFILES/zsh/export.zsh
source $DOTFILES/zsh/alias.zsh
FILE=$DOTFILES_PRIVATE/zsh/export.zsh && [ -f $FILE ] && source "$FILE"
FILE=$DOTFILES_PRIVATE/zsh/alias.zsh && [ -f $FILE ] && source "$FILE"
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
