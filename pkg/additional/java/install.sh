#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace java
Log::AddOutput java NOTE

# Ensure mise is available
mise::setup

# install java via brew
zerobrew::install openjdk

mise install java@17
mise use -g java@17

Log "Java $(java -version 2>&1 | head -1) installed"
