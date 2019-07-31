#!/bin/bash
source "$(dirname ${BASH_SOURCE})"/../framework/oo-bootstrap.sh

ZSH_VERSION=""
MIN_ZSH_VERSION="5.7.1"

if Command::Exists zsh; then
    ZSH_VERSION=$(zsh --version | cut -d " " -f 2)
fi

if [[ ${ZSH_VERSION} == "" ]] || (($(semver::compare ${ZSH_VERSION} ${MIN_ZSH_VERSION}) == -1)); then
    cd ${DOT_CACHE}
    local target_file="zsh-${MIN_ZSH_VERSION}.tar.xz"
    local target_path="zsh-${MIN_ZSH_VERSION}"

    if [[ ! -e ${target_file} ]]; then
        wget "https://sourceforge.net/projects/zsh/files/zsh/${MIN_ZSH_VERSION}/${target_file}/download" -O ${target_file}
    fi
    if [[ ! -d ${target_path} ]]; then
        tar -xvJf ${target_file}
    fi

    cd ${target_path}

    # install zsh to /bin/zsh
    ./configure --bindir=/bin
    make && sudo make install

    cd -

fi

[[ -n "$(grep "/zsh$" /etc/shells | tail -1)" ]] || sudo bash -c 'echo "/bin/zsh" >>/etc/shells'
