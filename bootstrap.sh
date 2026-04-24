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
ln -s ~/.local/squashfs-root/AppRun ~/.local/bin/nvim

# Bring in our custom neovim config
echo "XDG_CONFIG_HOME=$HOME" >> ~/.profile
git clone https://github.com/shea-parkes/neovim-config ~/.config/nvim
cd ~/.config/nvim
git submodule init
git submodule update

# Pre-compile Python treesitter parser
PARSER_DIR="$HOME/.local/share/nvim/site/parser"
mkdir -p "$PARSER_DIR"

TEMP_BUILD_DIR=$(mktemp -d)
echo "Building Python Tree-sitter parser in $TEMP_BUILD_DIR..."

git clone --depth 1 https://github.com/tree-sitter/tree-sitter-python "$TEMP_BUILD_DIR"

# Compile the .so file directly using gcc
# -O3: Optimize for performance
# -shared -fPIC: Required for dynamic loading by Neovim
# -Isrc: Include the header files in the src directory
gcc -O3 -shared -fPIC \
    -I"$TEMP_BUILD_DIR/src" \
    "$TEMP_BUILD_DIR/src/parser.c" \
    "$TEMP_BUILD_DIR/src/scanner.c" \
    -o "$PARSER_DIR/python.so"

rm -rf "$TEMP_BUILD_DIR"
echo "Python parser installed to $PARSER_DIR/python.so"

mkdir -p ~/.config/nvim/queries/python
curl -L https://raw.githubusercontent.com/tree-sitter/tree-sitter-python/master/queries/highlights.scm -o ~/.config/nvim/queries/python/highlights.scm
curl -L https://raw.githubusercontent.com/tree-sitter/tree-sitter-python/master/queries/folds.scm -o ~/.config/nvim/queries/python/folds.scm
curl -L https://raw.githubusercontent.com/tree-sitter/tree-sitter-python/master/queries/indents.scm -o ~/.config/nvim/queries/python/indents.scm


# Go ahead and configure vim as well while we're at it
git clone https://github.com/shea-parkes/vim-config ~/.vim
cd ~/.vim
git submodule init
git submodule update

# Capture browser/xdg-open URLs to a text file (for headless SSH)
cp "${BASH_SOURCE[0]%/*}/url-capture.sh" ~/.local/bin/url-capture
chmod +x ~/.local/bin/url-capture
ln -sf ~/.local/bin/url-capture ~/.local/bin/xdg-open
grep -qF 'export BROWSER=' ~/.profile || echo 'export BROWSER="$HOME/.local/bin/url-capture"' >> ~/.profile

# Setup git completions for bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
echo "source ~/.git-completion.bash" >> ~/.bashrc
