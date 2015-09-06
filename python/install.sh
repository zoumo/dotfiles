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
)

pip install --upgrade pip

# pyenv
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

pip install ${plugins[@]}