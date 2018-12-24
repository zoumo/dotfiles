#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

VERSION="11.5.0"

if ! Command::Exists nodenv; then
	if [[ $(OS::LSBDist) == "macos" ]]; then
		util::brew_install nodenv
		util::brew_install node-build
	else
		git::clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv
		cd ${HOME}/.nodenv && src/configure && make -C src
		mkdir -p ${HOME}/.nodenv/plugins
		git::clone https://github.com/nodenv/node-build.git ${HOME}/.nodenv/plugins/node-build
	fi
	# temporary export
	PATH="$HOME/.nodenv/bin:$PATH"
	eval "$(nodenv init -)"
fi

if [[ ! $(nodenv versions | grep ${VERSION}) ]]; then
	nodenv install ${VERSION}
fi

nodenv global ${VERSION}

# install yvm
# curl -fsSL https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.sh | bash
