#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace rust
Log::AddOutput rust NOTE

# Ensure mise is available
mise::setup

# Install Rust (latest stable) and set as global
mise use -g "rust"

Log "Rust $(rustc --version 2>/dev/null) installed"