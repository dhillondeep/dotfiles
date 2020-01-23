export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/deep/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  extract
  common-aliases
  encode64
  mvn
  node
  npm
  osx
  pip
  pylint
  python
  web-search
  wd
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# powerline settings
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status dir_writable load time)

# profile and custom aliases
alias avdmanager="~/Library/Android/sdk/tools/bin/avdmanager"
alias sdkmanager="~/Library/Android/sdk/tools/bin/sdkmanager"
alias cpwd="pwd | tr -d '\n' | pbcopy" # only for mac (copies pwd to clipboard)

# git alias
alias gitd="git diff --color-words"
alias gits="git status"
alias gitc="git commit"
alias gita="git add"

# tmux-session alias
alias tmux-session="tmux-session.sh"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# go
export GOPATH="$HOME/Development/gowork"
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# c++
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH=/usr/local/bin/:$PATH
export PATH="/usr/local/opt/llvm/bin:$PATH"
export CPATH=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include

# qt
export PATH="/usr/local/opt/qt/bin:$PATH"
export QT_DIR="$HOME/Applications/Qt/5.10.0/"
export PATH="$PATH:/Users/deep/Qt/5.13.0/clang_64/bin"

# bazel
export DEVELOPER_DIR=/Users/deep/Development/cio/rough-bazel-project

# python
export PATH="/Users/deep/Library/Python/2.7/bin:$PATH"

# flutter
export PATH=$PATH:$HOME/.pub-cache/bin

# scripts
export PATH=/Users/deep/Development/applications/git-archive-all.sh/git-archive-all.sh:$PATH
export PATH="/Users/deep/Development/applications/scripts:$PATH"

# aws
export AWS_PROFILE="assumed_role"
export AWS_DEFAULT_PROFILE="assumed_role"

# travis
[ -f /Users/deep/.travis/travis.sh ] && source /Users/deep/.travis/travis.sh

# brew
alias ctags="`brew --prefix`/bin/ctags"

# neovim
alias vim="nvim"

######################-begin-npm-completion-##########################
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
#######################-end-npm-completion-###########################

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/deep/Development/applications/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/deep/Development/applications/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/deep/Development/applications/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/deep/Development/applications/google-cloud-sdk/completion.zsh.inc'; fi

# import secrets and API keys if they exist
if [ -f $HOME/.zshrc_secret ]; then
    . $HOME/.zshrc_secret
    printf "zshrc_secret loaded!\n" 
fi

