# tmux alias
alias ta="tmux attach -t"
alias tn="tmux new -t"
alias tl="tmux list-sessions"
alias tap="tmux attach -t personal || tmux new -t personal"

# vim
alias vim="nvim"
alias svim="sudoedit nvim"

# use pip as user
alias pipi="pip install --user"

# faster tools
alias cat=bat
alias grep=rg
alias find=fd
alias ls=exa

# git
alias ga='git add'
alias gaa='git add --all'
alias gav='git add --verbose'

alias gb='git fuzzy branch'
alias gba='git fuzzy branch -a'
alias gbd='git fuzzy branch -d'
alias gbD='git fuzzy branch -D'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcb='git checkout -b'
alias gcl='git clone --recurse-submodules'
alias gpristine='git reset --hard && git clean -dffx'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'

alias gd='git fuzzy diff'

alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpush='git push origin "$(git_current_branch)"'

alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'

alias gl='git pull'
alias glg='git fuzzy log --stat'
alias glgp='git fuzzy log --stat -p'
alias glgg='git fuzzy log --graph'
alias glgga='git fuzzy log --graph --decorate --all'
alias glgm='git fuzzy log --graph --max-count=10'
alias glo='git fuzzy log --oneline --decorate'
alias glol="git fuzzy log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias glols="git fuzzy log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --stat"
alias glod="git fuzzy log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git fuzzy log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git fuzzy log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias glog='git fuzzy log --oneline --decorate --graph'
alias gloga='git fuzzyfuzzy  log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"

alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'
alias gma='git merge --abort'

alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpu='git push upstream'
alias gpv='git push -v'

alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase develop'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grh='git reset'
alias grhh='git reset --hard'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'

alias gsb='git fuzzy status -sb'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gss='git fuzzy status -s'
alias gst='git fuzzy status'

# zsh
alias zshreload='source ~/.zshrc'


# arch linux
if type pacman > /dev/null; then
    source $DOTFILES/zsh/arch_alias.zsh
fi

# macOS
if [[ `uname` == "Darwin" ]]; then
    source $DOTFILES/zsh/macos_alias.zsh
fi

# function

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}
