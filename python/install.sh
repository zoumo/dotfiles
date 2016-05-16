#!/bin/sh

plugins=(
    virtualenv
    powerline-status
    autopep8
    flake8
    docopt
    pytz
    requests
    unittest2
    thefuck
)

sudo pip install --upgrade pip

# pyenv
if [ ! -d ${HOME}/.pyenv ]; then
    curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
fi

if [ $OS == "centos" ]; then
    sudo yum install python-devel.x86_64
fi

sudo pip install ${plugins[@]}