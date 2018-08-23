#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

VERSION="9.11.2"

if ! Command::Exists nodenv; then
	if [[ $(OS::LSBDist) == "macos" ]]; then
		util::brew_install nodenv
	else
		git clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv
		cd ${HOME}/.nodenv && src/configure && make -C src
		mkdir ${HOME}/.nodenv/plugin
		git clone https://github.com/nodenv/node-build.git ${HOME}/.nodenv/plugin/node-build
	fi
fi

if [[ ! $(nodenv versions | grep ${VERSION}) ]]; then
	nodenv install ${VERSION}
fi

nodenv global ${VERSION}
