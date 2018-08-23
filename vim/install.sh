#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

cd ${plugins}

# 安装依赖
if [[ $(OS::LSBDist) == "macos" ]]; then
	util::brew_install ctags the_silver_searcher
	# mac中的vim版本太低, 换成macvim
	pyenv local system
	# use python3
	util::brew_install python
	util::brew_install_one macvim --with-override-system-vim
	pyenv local --unset

elif [[ $(OS::LSBDist) == 'centos' ]]; then
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
		# YouCompleteMe's python framwork must be the same with macvim
		pyenv local system
		python3 install.py --clang-completer
		pyenv local --unset
		cd ${plugins}/k-vim
	fi
	bash install.sh
fi
