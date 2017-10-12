#!/bin/bash

function info () {
    printf "  [ \033[00;34m..\033[0m ] $1\n"
}

function user () {
    printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

function success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

function fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

function command_exists() {
    command -v "$@" > /dev/null 2>&1
}

function find_installer() {
    declare -a result
    index=1
    for dir in $(ls)
    do
        if [[ -d $dir && -e $dir/install.sh ]]
        then
            result[$index]=$dir
            index=$(($index+1))
        fi
    done
    echo ${result[@]}
}

function brew_install () {
    for item in "$@"
    do
        if [[ ! $(brew list | grep -e "^$item$") ]] 
        then
            info "brew installing $item"
            brew install $item
        else
            info "brew_install: $item already exists, skip it"        
        fi
    done
}

function brew_install_one () {
    if [[ ! $(brew list | grep -e "^$1$") ]] 
    then
        info "brew installing $1"
        brew install "$@"
    else
        info "brew_install: $1 already exists, skip it"        
    fi
}

function pip_install () {
    for item in "$@"
    do
        if [[ ! $(pip show $item) ]] 
        then
            info "pip installing $item"
            pip install $item
        else
            info "pip_install: $item already exists, skip it"        
        fi
    done
}

function pip_install_one () {
    if [[ ! $(pip show $item) ]] 
    then
        info "pip installing $1"
        pip install "$@"
    else
        info "pip_install: $1 already exists, skip it"        
    fi
}


# ====================================================================
# detect os 

# set default
: ${os:=""}

# perform some very rudimentary platform detection
if command_exists lsb_release; then
    os="$(lsb_release -si)"
fi
if [ -z "$os" ] && [ -r /etc/lsb-release ]; then
    os="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
fi
if [ -z "$os" ] && [ -r /etc/debian_version ]; then
    os='debian'
fi
if [ -z "$os" ] && [ -r /etc/fedora-release ]; then
    os='fedora'
fi
if [ -z "$os" ] && [ -r /etc/oracle-release ]; then
    os='oracleserver'
fi
if [ -z "$os" ] && [ -r /etc/centos-release ]; then
    os='centos'
fi
if [ -z "$os" ] && [ -r /etc/redhat-release ]; then
    os='redhat'
fi
if [ -z "$os" ] && [ -r /etc/photon-release ]; then
    os='photon'
fi
if [ -z "$os" ] && [ -r /etc/os-release ]; then
    os="$(. /etc/os-release && echo "$ID")"
fi
if [ -z "$os" ] && [[ "$(uname -s)" == "Darwin" ]]; then
    os="macos"
fi

os="$(echo "$os" | cut -d " " -f1 | tr '[:upper:]' '[:lower:]')"

# Special case redhatenterpriseserver
if [ "${os}" = "redhatenterpriseserver" ]; then
        # Set it to redhat, it will be changed to centos below anyways
        lsb_dist='redhat'
fi

OS=$os


plugins=${HOME}/.dotfiles/plugins

if [[ ! -d ${plugins} ]]; then
    mkdir ${plugins}
fi

