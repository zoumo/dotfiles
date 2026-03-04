#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace nodejs
Log::AddOutput nodejs NOTE

VERSION="23.2.0"

# Ensure mise is available
mise::setup

# Install and set as global (mise use -g auto-installs)
mise use -g "node@${VERSION}"

Log "Node.js $(node --version 2>/dev/null) installed"