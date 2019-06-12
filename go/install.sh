#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

namespace golang
Log::AddOutput golang NOTE

if Command::Exists go; then
    Log "golang has already existed, skip it"
    go version
    exit 0
fi

if util::brewable; then
    util::brew_install go mercurial
elif [[ $(OS::LSBDist) == "centos" ]]; then
    sudo yum install -y golang
fi

exit 0
