# contains system setup files for arch
export SYSTEMSETUPS=$HOME/.system-setups

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/deep/Config/google-cloud-sdk/path.zsh.inc' ]; then . '/home/deep/Config/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/deep/Config/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/deep/Config/google-cloud-sdk/completion.zsh.inc'; fi
