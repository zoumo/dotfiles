#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source "${PKG_PATH}/../../../framework/oo-bootstrap.sh"

namespace cmux
Log::AddOutput cmux NOTE

if ! os::macos; then
    Log "cmux is macOS only, skipping"
    exit 0
fi

homebrew::cask::install cmux

Log "Configuring keybindings..."
bash "${PKG_PATH}/setup-keybindings.sh"

exit 0
