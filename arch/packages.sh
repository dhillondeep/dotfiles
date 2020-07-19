pacman -Sy git make neovim cmake ninja --noconfirm --needed
pacman -Sy alacritty zsh tmux xsel --noconfirm --needed
pacman -Sy exa bat fd ripgrep --noconfirm --needed
pacman -Sy gcc go nodejs yarn python --noconfirm --needed
pacman -Sy docker --noconfirm --needed

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
