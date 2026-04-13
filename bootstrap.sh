#!/bin/bash

cp .tmux.conf ~
cp .gitconfig ~
mkdir ~/.copilot
cp copilot-instructions.md ~/.copilot/

# ~Manually install NeoVim
mkdir -p ~/.local
cd ~/.local
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
mkdir ~/.local/bin

# Capture browser/xdg-open URLs to a text file (for headless SSH)
cp url-capture.sh ~/.local/bin/url-capture
chmod +x ~/.local/bin/url-capture
ln -s ~/.local/bin/url-capture ~/.local/bin/xdg-open
echo 'export BROWSER="$HOME/.local/bin/url-capture"' >> ~/.profile

ln -s ~/.local/squashfs-root/AppRun ~/.local/bin/nvim

# Bring in our custom neovim config
echo "XDG_CONFIG_HOME=$HOME" >> ~/.profile
git clone https://github.com/shea-parkes/neovim-config ~/.config/nvim
cd ~/.config/nvim
git submodule init
git submodule update

# Get Neovim mostly ready to go
cd /workspaces/$RepositoryName
# poetry run pip install pynvim ipython  # Avoid if we can help it
poetry run nvim --headless +":UpdateRemotePlugins" +"q!"

# Go ahead and configure vim as well while we're at it
git clone https://github.com/shea-parkes/vim-config ~/.vim
cd ~/.vim
git submodule init
git submodule update

# Setup git completions for bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
echo "source ~/.git-completion.bash" >> ~/.bashrc
