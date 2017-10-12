#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

if [[ $OS == "macos" ]]; then
    # Install homebrew packages
    info "homebrew installing"
    sh $HOME/.dotfiles/os/macos/install.sh
    success "homebrew install"

    # Set OS X defaults
    info "macos set-defaults"
    sh $HOME/.dotfiles/os/macos/set-defaults.sh
    success "macos set-defaults"
    
elif [[ $OS == "centos" ]]; then
    # prepare centos
    info "centos prepareing"
    info "centos prepared"
fi
