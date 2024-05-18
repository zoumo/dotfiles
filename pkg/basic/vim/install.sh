#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace vim
Log::AddOutput vim ERROR

# 安装依赖
if os::macos; then
    brew::cask::install macvim
else
    brew::install vim
fi

# use spacevim
curl -sLf https://spacevim.org/cn/install.sh | bash
