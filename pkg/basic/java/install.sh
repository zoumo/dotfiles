#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace java
Log::AddOutput java ERROR

brew::install openjdk mvnvm jenv

brew::shellenv

# https://github.com/jenv/jenv#12-configuring-your-shell
eval "$(jenv init -)"
jenv enable-plugin export
