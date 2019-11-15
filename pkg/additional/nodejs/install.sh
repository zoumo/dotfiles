#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace nodejs
Log::AddOutput nodejs NOTE

VERSION="11.5.0"

nodenv_from_src() {
    git::clone https://github.com/nodenv/nodenv.git ${HOME}/.nodenv
    cd ${HOME}/.nodenv && src/configure && make -C src
    mkdir -p ${HOME}/.nodenv/plugins
    git::clone https://github.com/nodenv/node-build.git ${HOME}/.nodenv/plugins/node-build
}

if ! Command::Exists nodenv; then
    brew::install nodenv

    # temporary export
    export PATH="$(brew --prefix nodenv)/bin:$PATH"

    mkdir -p "$(nodenv root)"/plugins
    git::clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
fi

if [[ ! $(nodenv versions | grep ${VERSION}) ]]; then
    Log "Installing nodejs ${VERSION}"
    nodenv install ${VERSION}
fi

nodenv global ${VERSION}
Log "nodenv versions:"
nodenv versions

# install yvm
# curl -fsSL https://raw.githubusercontent.com/tophat/yvm/master/scripts/install.sh | bash
