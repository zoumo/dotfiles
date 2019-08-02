#!/bin/bash
source "$(dirname ${BASH_SOURCE})"/../framework/oo-bootstrap.sh

brew::install zsh
zsh_bin="$(brew --prefix)/bin/zsh"
[[ -n "$(grep "${zsh_bin}" /etc/shells | tail -1)" ]] || sudo bash -c "echo ${zsh_bin} >>/etc/shells"

zsh_from_source() {
    ZSH_VERSION=""
    MIN_ZSH_VERSION="5.7.1"

    if Command::Exists zsh; then
        ZSH_VERSION=$(zsh --version | cut -d " " -f 2)
    fi

    if [[ ${ZSH_VERSION} == "" ]] || (($(semver::compare ${ZSH_VERSION} ${MIN_ZSH_VERSION}) == -1)); then
        cd ${DOT_CACHE}
        target_file="zsh-${MIN_ZSH_VERSION}.tar.gz"
        target_path="zsh-zsh-${MIN_ZSH_VERSION}"

        if [[ ! -e ${target_file} ]]; then
            wget "https://github.com/zsh-users/zsh/archive/${target_file}" -O ${target_file}
        fi

        rm -rf ${target_path} && tar -zxvf ${target_file}

        cd ${target_path}

        # install zsh to /bin/zsh
        ./Util/preconfig
        ./configure --bindir=/bin
        make && sudo make install
        cd -
    fi
    [[ -n "$(grep "/zsh$" /etc/shells | tail -1)" ]] || sudo bash -c 'echo "/bin/zsh" >>/etc/shells'
}
