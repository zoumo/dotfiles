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

VERSION=2.6

if ! util::command_exists tmux; then
	if [[ ${OS} == "macos" ]]; then
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

if [[ ! $(util::command_exists tmuxinator) && $(util::command_exists gem) ]]; then
	gem install tmuxinator
fi

exit 0
