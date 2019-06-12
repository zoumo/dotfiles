#!/bin/bash

source "$(dirname ${BASH_SOURCE})"/../../framework/oo-bootstrap.sh

namespace debian
Log::AddOutput debian NOTE

binaries=(
    build-essential
    curl
    file
    git
    clang
)

sudo apt-get update
sudo apt-get install -y ${binaries[@]}

# install zsh
bash ${DOT_ROOT}/zsh/install-zsh.sh

if util::brewable; then
    util::install_brew
fi
