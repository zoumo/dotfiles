#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source ${ROOT_PATH}/lib/init.sh

cd ${plugins}

# 安装依赖
if [[ ${OS} == "macos" ]]; then
	util::brew_install ctags the_silver_searcher
	# mac中的vim版本太低, 换成macvim
	pyenv local system
	util::brew_install python
	util::brew_install_one macvim --with-override-system-vim
	brew linkapps macvim
	pyenv local --unset

elif [[ ${OS} == 'centos' ]]; then
	wget -P /etc/yum.repos.d/ https://copr.fedorainfracloud.org/coprs/mcepl/vim8/repo/epel-7/mcepl-vim8-epel-7.repo
	yum remove -y vim-*
	yum install -y vim-enhanced
fi

# 可以选择安装
# brew tap neovim/neovim
# brew install --HEAD neovim
# pip install neovim

if [[ ! -e ${plugins}/YouCompleteMe.tar.gz ]]; then
	wget -O ${plugins}/YouCompleteMe.tar.gz "http://ohpunyak1.bkt.clouddn.com/YouCompleteMe.tar.gz?v=9999"
fi

if [[ ! -d ${plugins}/k-vim ]]; then
	git clone https://github.com/zoumo/k-vim.git
	cd k-vim/
	if [[ ! -d bundle/YouCompleteMe ]]; then
		export CC=/usr/bin/clang
		export CXX=/usr/bin/clang++
		mkdir -p bundle
		cd bundle
		tar -zxf ${plugins}/YouCompleteMe.tar.gz
		cd YouCompleteMe
		./install.py --clang-completer
		cd ${plugins}/k-vim
	fi
	sh install.sh
fi
