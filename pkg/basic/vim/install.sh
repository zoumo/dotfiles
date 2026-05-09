#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

namespace vim
Log::AddOutput vim NOTE

# 安装依赖
if os::macos; then
    zerobrew::install macvim
else
    zerobrew::install vim
fi

zerobrew::install neovim

cd "${DOT_PLUGINS}" || exit

git::clone https://github.com/LazyVim/starter starter

NVIM_CONFIG="${HOME}/.config/nvim"
NVIM_BACKUP="${NVIM_CONFIG}.bak"
NVIM_SOURCE="${DOT_PLUGINS}/starter"

mkdir -p "${HOME}/.config"

if [[ -L "${NVIM_CONFIG}" && "$(readlink "${NVIM_CONFIG}")" == "${NVIM_SOURCE}" ]]; then
    Log "nvim config already linked, skipping"
else
    if [[ -e "${NVIM_CONFIG}" || -L "${NVIM_CONFIG}" ]]; then
        backup="${NVIM_BACKUP}"
        i=1
        while [[ -e "${backup}" || -L "${backup}" ]]; do
            backup="${NVIM_BACKUP}.${i}"
            ((i++))
        done
        mv "${NVIM_CONFIG}" "${backup}"
    fi

    ln -s "${NVIM_SOURCE}" "${NVIM_CONFIG}"
fi
