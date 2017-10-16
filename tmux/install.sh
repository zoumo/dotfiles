#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

cd ${plugins}

VERSION=2.6

if ! command_exists tmux then
    if [[ $OS == "macos" ]]; then
        brew_install tmux
    else
        temp_dir=$(mktemp -d)
        cd $temp_dir
        wget https://github.com/tmux/tmux/releases/download/$VERSION/tmux-$VERSION.tar.gz
        tar xvzf tmux-$VERSION.tar.gz
        cd tmux-$VERSION
        LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
        make &&  make install
        cd ${plugins}
    fi

fi

if [[ ! -d ${plugins}/tmux ]]; then
    git clone https://github.com/gpakosz/.tmux.git ${plugins}/tmux
    ln -sf ${plugins}/tmux/.tmux.conf ${HOME}/.tmux.conf
fi

if [[ ! $(command_exists tmuxinator) && $(command_exists gem) ]]; then
    gem install tmuxinator
fi

exit 0
