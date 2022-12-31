#!/bin/bash

mkdir ~/bin
curl -L https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -o ~/.local/nvim.appimage
chmod u+x ~/.local/nvim.appimage
~/.local/nvim.appimage --appimage-extract
