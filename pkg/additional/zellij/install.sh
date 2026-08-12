#!/bin/bash

PKG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
# PKG_PATH is resolved at runtime so this works from any current directory.
# shellcheck disable=SC1091
source "${PKG_PATH}/../../../framework/oo-bootstrap.sh"

namespace zellij
Log::AddOutput zellij NOTE

zerobrew::install zellij

Log "Zellij installed"

exit 0
