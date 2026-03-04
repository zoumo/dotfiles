#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace golang
Log::AddOutput golang NOTE

VERSION="1.24.2"

# Ensure mise is available (lib/mise is auto-loaded via global.sh)
mise::setup

# Install and set as global (mise use -g auto-installs)
mise use -g "go@${VERSION}"

Log "Go $(go version 2>/dev/null | awk '{print $3}') installed"