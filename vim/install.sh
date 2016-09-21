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
elif [[ $OS == 'centos' ]]; then
    sudo yum install -y python-devel.x86_64
    sudo yum groupinstall -y 'Development Tools'
    sudo yum install -y the_silver_searcher
    sudo yum install -y cmake
fi


# 可以选择安装
# brew tap neovim/neovim
# brew install --HEAD neovim
# pip install neovim

git clone https://github.com/wklken/k-vim.git
cd k-vim/
sh -x install.sh