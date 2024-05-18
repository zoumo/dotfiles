#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source "${PKG_PATH}/../../../framework/oo-bootstrap.sh"

namespace alacritty
Log::AddOutput alacritty NOTE

brew::install alacritty

# install theme
ALACRITTY_CONFIG_PATH="${HOME}/.config/alacritty"
git::clone https://github.com/alacritty/alacritty-theme.git "${ALACRITTY_CONFIG_PATH}/themes"
