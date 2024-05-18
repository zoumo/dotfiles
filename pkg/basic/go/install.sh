#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace golang
Log::AddOutput golang NOTE

VERSION="go1.22.2"

brew::install go mercurial

# install gvm
if [[ ! -d "${HOME}/.gvm" ]]; then
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi

if ! Command::Exists gvm; then
    # shellcheck source=/dev/null
    source "${HOME}/.gvm/scripts/gvm"
fi

gvm install "${VERSION}" -B

exit 0
