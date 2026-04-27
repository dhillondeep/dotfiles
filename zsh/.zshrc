# Set preferred editor as Neovim
export EDITOR='nvim'

# set dotfiles location
export DOTFILES=${DOTFILES:-~/.dotfiles}
export DOTFILES_PRIVATE=${DOTFILES_PRIVATE:-~/.dotfiles.private}

# set local binaries location
path+=("$HOME/.local/bin")
path+=("$HOME/.atuin/bin")
typeset -gU path PATH

# Ghostty uses xterm-ghostty. Older remote hosts often do not know that
# terminfo entry yet, which breaks tmux, clear, and some zle widgets.
if [[ "${TERM:-}" == xterm-ghostty ]]; then
	if ! command -v infocmp >/dev/null 2>&1 || ! infocmp "$TERM" >/dev/null 2>&1; then
		export TERM=xterm-256color
	fi
fi

source_if_exists() {
	[ -r "$1" ] && source "$1"
}

if command -v mise >/dev/null 2>&1; then
	eval "$(mise activate zsh)"
	export MISE_INITIALIZED=1
fi

# initialize the completion system
autoload -Uz compinit
if [[ -n ~/.zcompdump(N.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

# setup zoxide
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init zsh)"
else
	source_if_exists ${DOTFILES}/zsh/zoxide.sh
fi

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

# Searchable shell history.
if command -v atuin >/dev/null 2>&1; then
	eval "$(atuin init zsh)"
	export ATUIN_INITIALIZED=1
fi

# ------- Plugins -------
# -----------------------

# - autocomplete -
if [[ "${DOTFILES_ZSH_AUTOCOMPLETE:-0}" == 1 ]]; then
	zstyle ':autocomplete:*' fzf-completion yes
	zstyle ':autocomplete:recent-dirs' backend zoxide
	zstyle ':autocomplete:*' widget-style menu-select
	source_if_exists ${DOTFILES}/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh 2>/dev/null
fi

# - syntax highlighting -
source_if_exists ${DOTFILES}/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# - alias tips -
if [[ "${DOTFILES_ALIAS_TIPS:-0}" == 1 ]]; then
	source_if_exists ${DOTFILES}/zsh/plugins/alias-tips/alias-tips.plugin.zsh
else
	autoload -Uz add-zsh-hook
	add-zsh-hook -d preexec _alias_tips__preexec 2>/dev/null
	unfunction _alias_tips__preexec 2>/dev/null
fi

# - vi mode -
export ZVM_INIT_MODE=sourcing
export ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
source_if_exists ${DOTFILES}/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# --------- FZF ---------
# -----------------------
if command -v fzf >/dev/null 2>&1 && [[ -o interactive && -t 0 && -t 1 ]]; then
	if fzf --zsh >/dev/null 2>&1; then
		eval "$(fzf --zsh)"
	else
		source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh
		source_if_exists /usr/share/doc/fzf/examples/completion.zsh
		source_if_exists /opt/homebrew/opt/fzf/shell/key-bindings.zsh
		source_if_exists /opt/homebrew/opt/fzf/shell/completion.zsh
		source_if_exists "$HOME/.fzf.zsh"
	fi
fi

# ------ Starship (Prompt) -------
# --------------------------------

export STARSHIP_CONFIG=$DOTFILES/zsh/starship.toml
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init zsh)"
fi

# ---------- Key Bindings ----------
# ----------------------------------

if [[ -n "${ATUIN_INITIALIZED:-}" ]]; then
	bindkey '^R' atuin-search
	bindkey "\e[A" atuin-up-search
	bindkey "\eOA" atuin-up-search
else
	bindkey "\e[A" history-beginning-search-backward
	bindkey "\eOA" history-beginning-search-backward
fi
bindkey "\e[B" history-beginning-search-forward
bindkey "\eOB" history-beginning-search-forward

if [[ -n "${ATUIN_INITIALIZED:-}" ]]; then
	bindkey -M viins '^R' atuin-search-viins
	bindkey -M vicmd '/' atuin-search-vicmd
	bindkey -M viins "\e[A" atuin-up-search-viins
	bindkey -M viins "\eOA" atuin-up-search-viins
	bindkey -M vicmd "\e[A" atuin-up-search-vicmd
	bindkey -M vicmd "\eOA" atuin-up-search-vicmd
else
	bindkey -M vicmd "\e[A" history-beginning-search-backward
	bindkey -M vicmd "\eOA" history-beginning-search-backward
fi
bindkey -M vicmd "\e[B" history-beginning-search-forward
bindkey -M vicmd "\eOB" history-beginning-search-forward

# --------- Configurations ---------
# ----------------------------------

source_if_exists $DOTFILES/zsh/export.zsh
source_if_exists $DOTFILES/zsh/alias.zsh
FILE=$DOTFILES_PRIVATE/zsh/export.zsh && [ -f $FILE ] && source "$FILE"
FILE=$DOTFILES_PRIVATE/zsh/alias.zsh && [ -f $FILE ] && source "$FILE"
FILE=~/.zshrc.local && [ -f "$FILE" ] && source "$FILE" # local

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

if [[ -z "${MISE_INITIALIZED:-}" ]]; then
	export NVM_DIR="$HOME/.nvm"
	_load_nvm() {
		unset -f nvm node npm npx yarn
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
		[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	}
	nvm() { _load_nvm; nvm "$@"; }
	node() { _load_nvm; node "$@"; }
	npm() { _load_nvm; npm "$@"; }
	npx() { _load_nvm; npx "$@"; }
	yarn() { _load_nvm; yarn "$@"; }
fi

for gcloud_root in \
	"$HOME/Lab/apps/gcloud-cli" \
	"/opt/homebrew/share/google-cloud-sdk" \
	"/usr/local/share/google-cloud-sdk" \
	"/usr/share/google-cloud-sdk"; do
	source_if_exists "$gcloud_root/path.zsh.inc"
	source_if_exists "$gcloud_root/completion.zsh.inc"
done

for autoenv_file in \
	"/opt/homebrew/opt/autoenv/activate.sh" \
	"/usr/local/opt/autoenv/activate.sh"; do
	source_if_exists "$autoenv_file"
done

source_if_exists "$HOME/.rye/env"

path+=(
	"$HOME/.modular/bin"
	"$HOME/.kubectl/plugins"
	"$HOME/.lmstudio/bin"
	"$HOME/.opencode/bin"
	"$HOME/.antigravity/antigravity/bin"
)
typeset -gU path PATH

if command -v aws-sso >/dev/null 2>&1; then
	__aws_sso_profile_complete() {
		local _args=${AWS_SSO_HELPER_ARGS:- -L error}
		_multi_parts : "($(command aws-sso ${=_args} list --csv Profile))"
	}

	aws-sso-profile() {
		local _args=${AWS_SSO_HELPER_ARGS:- -L error}
		if [ -n "$AWS_PROFILE" ]; then
			echo "Unable to assume a role while AWS_PROFILE is set"
			return 1
		fi

		if [ -z "$1" ]; then
			echo "Usage: aws-sso-profile <profile>"
			return 1
		fi

		eval "$(command aws-sso ${=_args} eval -p "$1")"
		[ "$AWS_SSO_PROFILE" = "$1" ]
	}

	aws-sso-clear() {
		local _args=${AWS_SSO_HELPER_ARGS:- -L error}
		if [ -z "$AWS_SSO_PROFILE" ]; then
			echo "AWS_SSO_PROFILE is not set"
			return 1
		fi
		eval "$(command aws-sso ${=_args} eval -c)"
	}

	compdef __aws_sso_profile_complete aws-sso-profile
	if (( $+functions[complete] || $+commands[complete] )); then
		complete -C "$(command -v aws-sso)" aws-sso
	fi
fi

argo_passwd() {
	kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d
}

argo_portfwd() {
	local service
	service="$(kubectl get services -n argocd | awk '/443/ { print $1; exit }')"
	kubectl port-forward "svc/$service" 8888:443 -n argocd
}
