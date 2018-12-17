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

# use spacevim
curl -sLf https://spacevim.org/install.sh | bash

ln -sf ${DOT_ROOT}/vim/init.toml ~/.SpaceVim.d/init.toml
ln -sf ${DOT_ROOT}/vim/zoumo.vim ~/.SpaceVim.d/autoload/zoumo.vim
