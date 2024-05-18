#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

# install fish fisher starship
brew::install fish fisher starship

# add fish to /etc/shells
shell_bin="$(brew --prefix)/bin/fish"
[[ -n "$(grep "${shell_bin}" /etc/shells | tail -1)" ]] || sudo bash -c "echo ${shell_bin} >>/etc/shells"

# install oh-my-fish
OMF_PATH="${HOME}/.oh-my-fish"

if [[ ! -d "${OMF_PATH}" ]]; then
    Log 'Installing oh-my-fish...'
    mkdir -p "${DOT_PLUGINS}/oh-my-fish"
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install >"${DOT_PLUGINS}/oh-my-fish/install"
    fish "${DOT_PLUGINS}/oh-my-fish/install" --path="${OMF_PATH}" --yes
fi

$shell_bin "${PKG_PATH}/plugin.fish"
