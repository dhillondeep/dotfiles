# Essential
arch -arm64 brew install nvim tmux

# Development
arch -arm64 brew install cmake make ninja yarn go

# Infra
arch -arm64 brew tap hashicorp/tap
arch -arm64 brew install docker docker-compose hashicorp/tap/terraform google-cloud-sdk pulumi

# Fast tools
arch -arm64 brew install bat exa fd rg fzf

# Terminal
arch -arm64 brew install starship
