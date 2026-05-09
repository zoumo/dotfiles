#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source "${PKG_PATH}/../../../framework/oo-bootstrap.sh"

namespace tmux
Log::AddOutput tmux NOTE

zerobrew::install tmux

# tmux session manager
# https://github.com/ivaaaan/smug
zerobrew::install smug

git::clone https://github.com/gpakosz/.tmux.git "${DOT_PLUGINS}/tmux"
ln -sf "${DOT_PLUGINS}/tmux/.tmux.conf" "${HOME}/.tmux.conf"

exit 0
