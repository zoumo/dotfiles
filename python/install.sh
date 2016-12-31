#!/bin/bash

set -e

ROOT_PATH="$(dirname ${BASH_SOURCE})"
VERSION="2.7.12"

function command_exists() {
    command -v "$@" > /dev/null 2>&1
}

if [[ $OS == "osx" ]]; then
    brew install readline xz
elif [[  $OS == "centos" ]]; then
    yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
fi

# install pyenv
if [[ ! -d ${HOME}/.pyenv ]]; then
    
    curl -fsSL https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
    source $ROOT_PATH/pyenv.zsh
    env PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang" pyenv install $VERSION
    pyenv global $VERSION
fi

# install plugins
plugins=(
    virtualenv
    autopep8
    flake8
    docopt
    pytz
    requests
    unittest2
    # thefuck
)

# update pip
pip install --upgrade pip

pip install ${plugins[@]}

