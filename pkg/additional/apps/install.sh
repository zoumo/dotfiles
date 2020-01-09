#!/bin/bash

source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

cd "${DOT_PLUGINS}" || exit 1

if os::macos; then
    # hammerspoon config
    git::clone https://github.com/zoumo/hammerspoon-config.git "${DOT_PLUGINS}/hammerspoon-config"
    # delete ~/.hammerspoon if it is not link
    [[ ! -L ${HOME}/.hammerspoon ]] && rm -rf "${HOME}/.hammerspoon"
    ln -sf "${DOT_PLUGINS}/hammerspoon-config" "${HOME}/.hammerspoon"
fi
