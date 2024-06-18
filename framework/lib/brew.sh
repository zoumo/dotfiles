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
    export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"
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
    brew::mirror

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # if [[ "$(OS::LSBDist)" == "macos" ]]; then
    #     # install homebrew
    #     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # elif [[ ! -d /home/linuxbrew/.linuxbrew ]]; then
    #     HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-'/home/linuxbrew/.linuxbrew'}"
    #     # create linuxbrew user to install homebrew
    #     sudo id -u linuxbrew >/dev/null 2>&1 || sudo useradd -m -s /bin/bash linuxbrew
    #     # add permission for normal user
    #     sudo chmod 0755 /home/linuxbrew
    #     # enable sudo
    #     sudo grep -q "linuxbrew ALL" /etc/sudoers || sudo bash -c "echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers"
    #     if [[ "$(whoami)" != "root" ]]; then
    #         # add current user to group linuxbrew
    #         groups "$USER" | grep -q linuxbrew || sudo usermod -a -G linuxbrew "$USER"
    #     fi
    #     # install homebrew by linuxbrew user
    #     # -E to preserve environment variables
    #     # -u to run as user linuxbrew
    #     sudo -E -u linuxbrew bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # fi
}

brew::install() {
    if ! brew::verify; then
        return
    fi
    brew_list=($(brew list -1))
    for item in "$@"; do
        if ! Array::Contains "$item" "${brew_list[@]}"; then
            Log "brew installing $item"
            brew install "$item"
        else
            Log "brew::install: $item already exists, skip it"
        fi
    done
}

brew::install_one() {
    if ! brew::verify; then
        return
    fi
    brew_list=($(brew list -1))
    if Array::Contains "${1}" "${brew_list[@]}"; then
        Log "brew::install: $1 already exists, skip it"
    else
        Log "brew installing $1"
        brew install "$@"
    fi
}

brew::cask::install() {
    if ! brew::verify; then
        return
    fi
    brew_list=($(brew list -1))
    if Array::Contains "${1}" "${brew_list[@]}"; then
        Log "brew::cask::install: $1 already exists, skip it"
    else
        Log "brew installing $1"
        brew install --cask --appdir="/Applications" "$@"
    fi
}
