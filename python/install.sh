#!/bin/bash

set -e

ROOT_PATH="$(dirname ${BASH_SOURCE})"
VERSION="2.7.12"

function command_exists() {
    command -v "$@" > /dev/null 2>&1
}

# install pyenv
if [[ ! -d ${HOME}/.pyenv ]]; then
    curl -fsSL https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
    source $ROOT_PATH/pyenv.zsh
    pyenv install $VERSION
    pyenv global $VERSION
fi

# install python and pip

# if [[ $OS == "osx" ]]; then
#     brew install python
# elif [[  $OS == "centos" ]]; then
#     # # pip
#     # sudo yum install -y python-pip || ( curl -fsSL https://bootstrap.pypa.io/get-pip.py | sudo python )
#     # # python development packages
#     # sudo yum install -y python-devel.x86_64

#     pyenv install 2.7.12

# fi

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

