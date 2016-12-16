#!/bin/bash

set -e

if [[ $OS == "osx" ]]; then
    brew install go
    brew install mercurial
    bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
fi

exit 0