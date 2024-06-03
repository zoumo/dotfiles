#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace java
Log::AddOutput java ERROR

brew::install openjdk maven
