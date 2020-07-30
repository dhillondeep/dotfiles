sudo pacman -Sy git make neovim cmake ninja which --noconfirm --needed
sudo pacman -Sy alacritty zsh tmux xsel --noconfirm --needed
sudo pacman -Sy exa bat fd ripgrep --noconfirm --needed
sudo pacman -Sy gcc go nodejs yarn python openssh python3 python-pip ruby --noconfirm --needed
sudo pacman -Sy docker --noconfirm --needed

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
