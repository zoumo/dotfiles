#!/bin/sh

# install python and pip
if [[ $OS == "osx" ]]; then
    brew install python
elif [[  $OS == "centos" ]]; then
    # pip
    sudo yum install -y python-pip || ( curl -fsSL https://bootstrap.pypa.io/get-pip.py | sudo python )
    # python development packages
    sudo yum install -y python-devel.x86_64
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
    thefuck
)

# update pip
sudo pip install --upgrade pip

sudo pip install ${plugins[@]}

# install pyenv
if [[ ! -d ${HOME}/.pyenv ]]; then
    curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
fi