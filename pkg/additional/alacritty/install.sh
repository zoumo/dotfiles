#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source "${PKG_PATH}/../../../framework/oo-bootstrap.sh"

namespace alacritty
Log::AddOutput alacritty NOTE

brew::install alacritty

ALACRITTY_CONFIG_PATH="${HOME}/.config/alacritty"

if [ ! -d "${ALACRITTY_CONFIG_PATH}" ]; then
    mkdir -p "${ALACRITTY_CONFIG_PATH}"
fi

# link alacritty config
ln -sf "${PKG_PATH}/alacritty.toml" "${ALACRITTY_CONFIG_PATH}/alacritty.toml"

# install theme
git::clone https://github.com/alacritty/alacritty-theme "${ALACRITTY_CONFIG_PATH}/themes"
