# !/bin/sh

plugins=${HOME}/.dotfiles/plugins

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
    sudo yum install -y vim
fi


# 可以选择安装
# brew tap neovim/neovim
# brew install --HEAD neovim
# pip install neovim

if [[ ! -d ${plugins}/k-vim ]]; then
    git clone https://github.com/wklken/k-vim.git
fi
cd k-vim/
sh install.sh