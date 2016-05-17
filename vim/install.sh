# !/bin/sh

plugins=${HOME}/plugins

if [[ ! -d ${plugins} ]]; then
    mkdir ${plugins}
fi

cd ${plugins}

# 安装依赖
if [[ $OS == "osx" ]]; then
    brew install ctags
    brew install the_silver_searcher
fi

# 可以选择安装
# brew tap neovim/neovim
# brew install --HEAD neovim
# pip install neovim

git clone https://github.com/wklken/k-vim.git
cd k-vim/
sh -x install.sh