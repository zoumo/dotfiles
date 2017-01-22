#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

plugins=${HOME}/.dotfiles/plugins

if [[ ! -d ${plugins} ]]; then
    mkdir ${plugins}
fi

cd ${plugins}


# 安装依赖
if [[ $OS == "osx" ]]; then
    brew_install ctags the_silver_searcher
    # mac中的vim版本太低, 换成macvim
    pyenv local system
    brew_install python
    brew_install_one macvim --override-system-vim
    brew linkapps macvim
    pyenv local --unset
    
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
    git clone https://github.com/zoumo/k-vim.git
    cd k-vim/
    sh install.sh
fi
