#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

cd ${plugins}


# 安装依赖
if [[ $OS == "macos" ]]; then
    brew_install ctags the_silver_searcher
    # mac中的vim版本太低, 换成macvim
    pyenv local system
    brew_install python
    brew_install_one macvim --with-override-system-vim
    brew linkapps macvim
    pyenv local --unset
    
elif [[ $OS == 'centos' ]]; then
    wget -P /etc/yum.repos.d/  https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo
    sudo yum install -y python-devel.x86_64
    sudo yum groupinstall -y 'Development Tools'
    sudo yum install -y the_silver_searcher
    sudo yum install -y cmake
    sudo yum -y install vim-enhanced
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
