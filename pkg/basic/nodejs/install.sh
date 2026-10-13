#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace nodejs
Log::AddOutput nodejs NOTE

VERSION="24.21.0"

# Ensure mise is available
mise::setup

# Set mirror URL
mise settings node.mirror_url=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/

# Install and set as global (mise use -g auto-installs)
mise use -g "node@${VERSION}"

# install bun
homebrew::tap::install oven-sh/bun/bun

Log "Node.js $(node --version) installed"
