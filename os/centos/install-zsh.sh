#!/bin/bash
source "$(dirname ${BASH_SOURCE})"/../../framework/oo-bootstrap.sh

ZSH_VERSION=""
MIN_ZSH_VERSION="5.7.1"

if Command::Exists zsh; then
    ZSH_VERSION=$(zsh --version | cut -d " " -f 2)
fi

if [[ ${ZSH_VERSION} == "" ]] || (($(semver::compare ${ZSH_VERSION} ${MIN_ZSH_VERSION}) == -1)); then
    wget "https://sourceforge.net/projects/zsh/files/zsh/${MIN_ZSH_VERSION}/zsh-${MIN_ZSH_VERSION}.tar.xz/download" -O zsh-${MIN_ZSH_VERSION}.tar.xz

    tar -xvJf zsh-${MIN_ZSH_VERSION}.tar.xz
    cd zsh-${MIN_ZSH_VERSION}

    # install zsh to /bin/zsh
    ./configure --bindir=/bin

    make && sudo make install
    rm -rf zsh-${MIN_ZSH_VERSION}.tar.xz zsh-${MIN_ZSH_VERSION}

fi
