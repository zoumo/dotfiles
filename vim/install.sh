# !/bin/sh

plugins=${HOME}/plugins

if [[ ! -d ${plugins} ]]; then
    mkdir ${plugins}
fi

cd ${plugins}

# mac中的vim版本太低, 换成macvim
echo "Installing macvim..."
brew install macvim --override-system-vim
brew linkapps macvim

# 安装依赖
brew install ctags
brew install the_silver_searcher

# 可以选择安装
# brew tap neovim/neovim
# brew install --HEAD neovim
# pip install neovim

# git clone https://github.com/wklken/k-vim.git
# cd k-vim/
# sh -x install.sh