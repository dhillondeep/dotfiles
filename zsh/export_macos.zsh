export LANG="en_US.UTF-8"

# Gcloud

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/deep/Development/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/deep/Development/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/deep/Development/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/deep/Development/tools/google-cloud-sdk/completion.zsh.inc'; fi

# brew gcloud
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"