#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

cd ${plugins}

VERSION=2.7

if ! Command::Exists tmux; then
	if [[ $(OS::LSBDist) == "macos" ]]; then
		util::brew_install tmux
	else
		temp_dir=$(mktemp -d)
		cd ${temp_dir}
		wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
		tar xvzf tmux-${VERSION}.tar.gz
		cd tmux-${VERSION}
		LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
		make && make install
		cd ${plugins}
	fi
fi

if [[ ! -d ${plugins}/tmux ]]; then
	git clone https://github.com/gpakosz/.tmux.git ${plugins}/tmux
	ln -sf ${plugins}/tmux/.tmux.conf ${HOME}/.tmux.conf
fi

if [[ ! $(Command::Exists tmuxinator) && $(Command::Exists gem) ]]; then
	gem install tmuxinator
	mkdir -p ${HOME}/.tmuxinator
	ln -sf ${DOT_ROOT}/tmux/zoumo.yaml ${HOME}/.tmuxinator/zoumo.yml
fi

# link tmux local
ln -sf ${DOT_ROOT}/tmux/.tmux.conf.local ${HOME}/.tmux.conf.local

exit 0
