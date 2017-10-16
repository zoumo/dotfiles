#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

# prepare os
info "$OS installing"
sh $HOME/.dotfiles/os/$OS/install.sh
success "$OS install"

if [[ $OS == "macos" ]]; then
    # Set OS X defaults
    info "macos set-defaults"
    sh $HOME/.dotfiles/os/macos/set-defaults.sh
    success "macos set-defaults"
fi
