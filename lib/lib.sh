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