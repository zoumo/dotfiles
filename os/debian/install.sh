#!/bin/bash

source "$(dirname ${BASH_SOURCE})"/../../framework/oo-bootstrap.sh

namespace debian
Log::AddOutput debian NOTE

binaries=(
    build-essential
    curl
    file
    git
    clang
    automake
    yodl
    perl
    libevent-dev
)

sudo apt-get update
sudo apt-get install -y "${binaries[@]}"

brew::setup
