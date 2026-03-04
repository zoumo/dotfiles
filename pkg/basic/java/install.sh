#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace java
Log::AddOutput java NOTE

VERSION="21"

# Ensure mise is available
mise::setup

# Install and set as global (mise use -g auto-installs)
mise use -g "java@${VERSION}"

# Enable JAVA_HOME setting
mise settings set java.java_home true 2>/dev/null || true

Log "Java $(java -version 2>&1 | head -1) installed"