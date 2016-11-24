#!/bin/bash

set -e

if [[ $OS == "osx" ]]; then
    brew install go
fi

exit 0