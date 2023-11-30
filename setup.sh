#!/bin/bash

# get root level permission
if [ $EUID != 0 ]; then
	sudo "$0" "$@"
	exit $?
fi

# updating packages before doing anything
sudo apt upgrade -y

# terminal profile
sudo dnf install -y xset @development-tools clang 
rm ~/.bash_profile
ln -s ~/.config/profile ~/.bash_profile

# browser
sudo dnf remove -y firefox
sudo dnf install -y chromium

# lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install -y lazygit

# terminal
sudo dnf install -y kitty tmux

# neovim
sudo dnf install -y neovim fzf ripgrep 
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node

