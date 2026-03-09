#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace java
Log::AddOutput java NOTE

# Ensure mise is available
mise::setup

# install java via brew
brew::install openjdk 

# link java@brew
mise link --force java@brew "$(brew --prefix openjdk)"
mise use -g "java@brew"

Log "Java $(java -version 2>&1 | head -1) installed"
