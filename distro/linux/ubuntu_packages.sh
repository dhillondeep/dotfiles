sudo apt install -y git make neovim cmake ninja-build
sudo apt install -y zsh tmux xsel bat
sudo apt install -y build-essential golang nodejs yarn python openssh-client python3 python3-pip ruby yarn
sudo apt install -y docker docker-compose

# bat
sudo ln -s /usr/bin/batcat /usr/bin/bat

# yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn

# exa
cd /tmp && wget -c https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip
cd /tmp && unzip exa-linux-x86_64-0.9.0.zip
cd /tmp && sudo mv exa-linux-x86_64 /usr/local/bin/exa

# ripgrep
cd /tmp && wget -c https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
cd /tmp && sudo apt install ./ripgrep_12.1.1_amd64.deb

# fd
cd /tmp && wget -c https://github.com/sharkdp/fd/releases/download/v8.1.1/fd_8.1.1_amd64.deb
cd /tmp && sudo apt install ./fd_8.1.1_amd64.deb

# fzf
if [ ! -d ~/.fzf ]; then
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
fi
