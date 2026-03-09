#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace rust
Log::AddOutput rust NOTE

# Ensure mise is available
mise::setup

# mise use rustup to install Rust, set rustup mirror
export RUSTUP_UPDATE_ROOT="https://mirrors.aliyun.com/rustup/rustup"
export RUSTUP_DIST_SERVER="https://mirrors.aliyun.com/rustup"

# Install Rust (latest stable) and set as global
mise -y use -g "rust@stable"

Log "Rust $(rustc --version 2>/dev/null) installed"
