#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace golang
Log::AddOutput golang NOTE

VERSION="1.24.13"

# Ensure mise is available (lib/mise is auto-loaded via global.sh)
mise::setup

# use mirror and skip checksum
mise settings go_download_mirror https://mirrors.aliyun.com/golang
mise settings go_skip_checksum true

# Install and set as global (mise use -g auto-installs)
mise use -g "go@${VERSION}"

Log "Go $(go version 2>/dev/null | awk '{print $3}') installed"
