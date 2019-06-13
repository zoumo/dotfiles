#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

namespace python
Log::AddOutput python NOTE

GLOBAL_VERSION="3.7.3"
VERSIONS=("2.7.16" ${GLOBAL_VERSION})

if [[ $(OS::LSBDist) == "centos" ]]; then
    sudo yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
elif [[ $(OS::LSBDist) == "debian" ]]; then
    sudo apt-get install -y make build-essential zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev python-openssl git
fi

if util::brewable; then
    util::brew_install readline xz zlib openssl@1.1
    export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib"
    export CPPFLAGS="-I$(brew --prefix openssl@1.1)/include"
fi

# install pyenv
if ! Command::Exists pyenv; then
    [[ -d ${HOME}/.pyenv ]] || curl -fsSL "https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer" | bash

    # temporary export
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    # make cache
    mkdir -p $(pyenv root)/cache

fi

# update pyenv firstly
pyenv update

for VERSION in ${VERSIONS[@]}; do
    if [[ ! $(pyenv versions | grep ${VERSION}) ]]; then
        Log "Installing python ${VERSION}"
        if [[ $(OS::LSBDist) == "macos" ]]; then
            env CONFIGURE_OPTS="--enable-framework CC=clang --with-openssl=$(brew --prefix openssl@1.1)" pyenv install ${VERSION} -v
        else
            env CONFIGURE_OPTS="--enable-shared CC=clang" pyenv install ${VERSION} -v
        fi
    fi
done

# set global version
pyenv global ${GLOBAL_VERSION}

# install plugins
plugins=(
    virtualenv
    autopep8
    flake8
    docopt
    pytz
    requests
    unittest2
    arrow
    thefuck
    neovim
)

# update pip
util::pip_install_one --upgrade pip

util::pip_install ${plugins[@]}
