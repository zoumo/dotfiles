#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

cd ${plugins}

if [[ $OS == "macos" ]]; then
    brew_install tmux
fi

if [[ ! -d ${plugins}/tmux ]]; then
    git clone https://github.com/gpakosz/.tmux.git ${plugins}/tmux
    ln -sf ${plugins}/tmux/.tmux.conf ${HOME}/.tmux.conf
fi

if ! command_exists tmuxinator; then
    gem install tmuxinator
fi

exit 0
