# Only for XTerm emulator
export TERM="xterm-256color"

export ZSH=~/.oh-my-zsh

ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  encode64
  wd
)

source $ZSH/oh-my-zsh.sh

##################### User configuration #####################

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# powerline settings
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status dir_writable)

# tmux alias
alias ta="tmux attach -t"
alias tn="tmux new -t"
alias tl="tmux list-sessions"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPS="--extended"
