#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

if Command::Exists go; then
    exit 0
fi

if [[ $(OS::LSBDist) == "macos" ]]; then
    util::brew_install go mercurial
    # bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
elif [[ $(OS::LSBDist) == "centos" ]]; then
    sudo yum install -y golang
fi

exit 0
