#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace tmux
Log::AddOutput tmux NOTE

cd ${DOT_PLUGINS}

VERSION=2.7

tmux_from_src() {
    temp_dir=$(mktemp -d)
    cd ${temp_dir}
    wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
    tar xvzf tmux-${VERSION}.tar.gz
    cd tmux-${VERSION}
    LDFLAGS="-L/usr/local/lib -Wl,-rpath=/usr/local/lib" ./configure --prefix=/usr/local
    make && make install
    cd ${DOT_PLUGINS}
}

if ! Command::Exists tmux; then
    brew::install tmux
fi

git::clone https://github.com/gpakosz/.tmux.git ${DOT_PLUGINS}/tmux
ln -sf ${DOT_PLUGINS}/tmux/.tmux.conf ${HOME}/.tmux.conf
# link tmux local
ln -sf ${PKG_PATH}/.tmux.conf.local ${HOME}/.tmux.conf.local

if Command::Exists gem; then
    if ! Command::Exists tmuxinator; then
        gem install tmuxinator
    fi
    mkdir -p ${HOME}/.tmuxinator

    ln -sf ${PKG_PATH}/zoumo.yaml ${HOME}/.tmuxinator/zoumo.yml
fi

exit 0
