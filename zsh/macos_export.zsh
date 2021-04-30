export LANG="en_US.UTF-8"

# Gcloud

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/deep/Development/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/deep/Development/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/deep/Development/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/deep/Development/tools/google-cloud-sdk/completion.zsh.inc'; fi

# brew gcloud
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"


# Git fzf
export PATH=$PATH:~/Applications/git-fuzzy/bin

# Ruby
export PATH="/usr/local/opt/ruby@2.7/bin:$PATH"

if which ruby >/dev/null && which gem >/dev/null; then
    export PATH="$(ruby -r rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi
