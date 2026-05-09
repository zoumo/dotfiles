#!/bin/bash
import util/log
import Array/Contains
import lib/semver
# enable basic logging for this file by declaring a namespace
namespace lib/brew
# make the Log method direct everything in the namespace 'myApp' to the log handler called DEBUG
Log::AddOutput lib/brew STATUS

readonly BREW_MIN_VERSION="3.3.6"

brew::mirror() {
    # export HOMEBREW_API_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles/api"
    # export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.aliyun.com/homebrew-bottles"
    # export HOMEBREW_PIP_INDEX_URL="http://mirrors.aliyun.com/pypi/simple"
    # export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/brew.git"
    # export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.aliyun.com/homebrew/homebrew-core.git"

    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    export HOMEBREW_PIP_INDEX_URL="https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"
    # export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    # export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
}

brew::unmirror() {
    unset HOMEBREW_API_DOMAIN
    unset HOMEBREW_BOTTLE_DOMAIN
    unset HOMEBREW_BREW_GIT_REMOTE
    unset HOMEBREW_CORE_GIT_REMOTE
    unset HOMEBREW_PIP_INDEX_URL
}

brew::shellenv() {
    if [[ "$(OS::LSBDist)" == "macos" ]]; then
        if [[ "$(OS::Arch)" == "arm64" ]]; then
            export HOMEBREW_PREFIX="/opt/homebrew"
        else
            export HOMEBREW_PREFIX="/usr/local"
        fi
    else
        export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
        export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
        export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
    fi
    export HOMEBREW_NO_INSTALL_CLEANUP="true"
    export PATH="${HOMEBREW_PREFIX}/bin:${PATH}"
}

brew() {
    brew::mirror
    brew::shellenv

    "${HOMEBREW_PREFIX}"/bin/brew "$@"
}

brew::verify() {
    brew_version=$(brew --version | head -1 | cut -d " " -f 2)
    if (($(semver::compare_version "${brew_version}" "${BREW_MIN_VERSION}") == -1)); then
        Log "brew version is too old, please use brew update to upgrade brew"
        # brew version is less than min version
        return 1
    fi
    return 0
}

brew::setup() {
    # set up homebrew
    brew::mirror
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # setup zerobrew
    curl -fsSL https://zerobrew.rs/install | bash
}

homebrew::install() {
    if ! brew::verify; then
        return
    fi
    brew_list=($(brew list -1))
    for item in "$@"; do
        if ! Array::Contains "$item" "${brew_list[@]}"; then
            Log "brew installing $item"
            brew install "$item"
        else
            Log "homebrew::install: $item already exists, skip it"
        fi
    done
}

homebrew::tap::install() {
    if ! brew::verify; then
        return
    fi
    brew_tap_list=($(brew tap))
    for item in "$@"; do
        tap="${item%/*}"
        formula="${item##*/}"

        if [[ "${tap}" == "${item}" ]]; then
            Log "homebrew::tap::install: $item is not a tapped formula"
            return 1
        fi

        if ! Array::Contains "$tap" "${brew_tap_list[@]}"; then
            Log "brew tapping $tap"
            brew tap "$tap" || return 1
            brew_tap_list+=("$tap")
        else
            Log "homebrew::tap::install: $tap already exists, skip it"
        fi

        if brew list --formula "$formula" >/dev/null 2>&1; then
            Log "homebrew::tap::install: $formula already exists, skip it"
        else
            Log "brew installing $item"
            brew install "$item" || return 1
        fi
    done
}

homebrew::cask::install() {
    if ! brew::verify; then
        return
    fi
    brew_cask_list=($(brew list --cask -1))
    for item in "$@"; do
        if Array::Contains "${item}" "${brew_cask_list[@]}"; then
            Log "homebrew::cask::install: $item already exists, skip it"
        else
            Log "brew cask installing $item"
            brew install --cask --appdir="/Applications" -f "$item" || return 1
            brew_cask_list+=("$item")
        fi
    done
}


zb() {
    zerobrew::shellenv
    "$ZEROBREW_BIN"/zb "$@"
}

zerobrew::shellenv() {
    if [[ "$(OS::LSBDist)" == "macos" ]]; then
        export ZEROBREW_ROOT="/opt/zerobrew"
        export ZEROBREW_PREFIX=$ZEROBREW_ROOT
    else
        XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
        export ZEROBREW_ROOT="$XDG_DATA_HOME/zerobrew"
        export ZEROBREW_PREFIX=$ZEROBREW_ROOT/prefix
    fi
    export PATH="${ZEROBREW_PREFIX}/bin:${PATH}"
    export ZEROBREW_BIN="$HOME"/.local/bin
}

zerobrew::install() {
    zb_list=($(zb list))
    for item in "$@"; do
        if ! Array::Contains "$item" "${zb_list[@]}"; then
            Log "zerobrew installing $item"
            zb install "$item"
        else
            Log "zerobrew::install: $item already exists, skip it"
        fi
    done
}
