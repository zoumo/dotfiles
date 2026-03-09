#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace vim
Log::AddOutput vim ERROR

# 安装依赖
if os::macos; then
    brew::install macvim
else
    brew::install vim
fi

brew::install neovim

cd "${DOT_PLUGINS}" || exit

git::clone https://github.com/LazyVim/starter starter

if [[ -d "${HOME}/.config/nvim" ]];then
   mv "${HOME}/.config/nvim" "${HOME}/.config/nvim.bak"
fi

ln -sf "${DOT_PLUGINS}/starter" "${HOME}/.config/nvim"
