#!/bin/bash

# ~Manually install NeoVim
cd ~/.local
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
ln -s ~/.local/squashfs-root/AppRun nvim

# Bring in our custom neovim config
echo "XDG_CONFIG_HOME=$HOME" >> .profile
mkdir ~/.config
cd ~/.config
git clone https://github.com/shea-parkes/neovim-config nvim
cd ~/.config/nvim
git submodule init
git submodule update
