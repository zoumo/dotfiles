#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

cd ${DOT_PLUGINS}

VERSION=2.7

if ! Command::Exists tmux; then
    if util::brewable; then
        util::brew_install tmux
    else
        temp_dir=$(mktemp -d)
        cd ${temp_dir}
        wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
        tar xvzf tmux-${VERSION}.tar.gz
        cd tmux-${VERSION}
        LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
        make && make install
        cd ${DOT_PLUGINS}
    fi
fi

git::clone https://github.com/gpakosz/.tmux.git ${DOT_PLUGINS}/tmux
ln -sf ${DOT_PLUGINS}/tmux/.tmux.conf ${HOME}/.tmux.conf
# link tmux local
ln -sf ${DOT_ROOT}/tmux/.tmux.conf.local ${HOME}/.tmux.conf.local

if Command::Exists gem; then
    if ! Command::Exists tmuxinator; then
        gem install tmuxinator
    fi
    mkdir -p ${HOME}/.tmuxinator
    ln -sf ${DOT_ROOT}/tmux/zoumo.yaml ${HOME}/.tmuxinator/zoumo.yml
fi

exit 0
