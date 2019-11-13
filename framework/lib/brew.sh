#!/bin/bash
import util/log
import Array/Contains
# enable basic logging for this file by declaring a namespace
namespace lib/brew
# make the Log method direct everything in the namespace 'myApp' to the log handler called DEBUG
Log::AddOutput lib/brew STATUS

brew() {
    if [[ "$(OS::LSBDist)" == "macos" ]]; then
        /usr/local/bin/brew $@
        return
    fi

    if [[ ${HOMEBREW_PREFIX:-} == "" ]]; then
        export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
        export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
        export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
    fi
    sudo su - linuxbrew bash -c "${HOMEBREW_PREFIX}/bin/brew $*"
}

brew::mirror() {
    git -C "$(brew --repo)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git
    git -C "$(brew --repo homebrew/core)" remote set-url origin https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git

    brew update
}

brew::unmirror() {
    git -C "$(brew --repo)" remote set-url origin https://github.com/Homebrew/brew.git
    git -C "$(brew --repo homebrew/core)" remote set-url origin https://github.com/Homebrew/homebrew-core
    brew update
}

brew::setup() {
    if [[ "$(OS::LSBDist)" == "macos" ]]; then
        # install homebrew
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    elif [[ ! -d /home/linuxbrew/.linuxbrew ]]; then
        HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-'/home/linuxbrew/.linuxbrew'}"

        sudo id -u linuxbrew >/dev/null 2>&1 || sudo useradd -m -s /bin/bash linuxbrew
        sudo grep -q "linuxbrew ALL" /etc/sudoers || sudo bash -c "echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers"

        if [[ "$(whoami)" != "root" ]]; then
            # add current user to group linuxbrew
            [[ -n $(groups $USER | grep linuxbrew) ]] || sudo usermod -a -G linuxbrew $USER
        fi

        sudo mkdir -p /home/linuxbrew/.linuxbrew
        [[ -d /home/linuxbrew/.linuxbrew/Homebrew ]] || sudo git clone https://github.com/Homebrew/brew.git /home/linuxbrew/.linuxbrew/Homebrew

        cd /home/linuxbrew/.linuxbrew
        sudo mkdir -p bin etc include lib opt sbin share var/homebrew/linked Cellar
        sudo ln -sf ../Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/

        # change owner
        sudo chown -R linuxbrew: /home/linuxbrew/.linuxbrew

        # install linuxbrew
        # use echo to skip "Press RETURN to continue or any other key to abort"
        # echo | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    fi
}

brew::install() {
    local brew_list=($(brew list))
    for item in "$@"; do
        if ! Array::Contains $item ${brew_list[@]}; then
            Log "brew installing $item"
            brew install $item
        else
            Log "brew::install: $item already exists, skip it"
        fi
    done
}

brew::install_one() {
    if [[ ! $(brew list | grep -e "^$1$") ]]; then
        Log "brew installing $1"
        brew install "$@"
    else
        Log "brew::install: $1 already exists, skip it"
    fi
}

brew::cask::install() {
    if [[ ! $(brew cask list | grep -e "^$1$") ]]; then
        Log "brew installing $1"
        brew cask install --appdir="/Applications" "$@"
    else
        Log "brew::cask::install: $1 already exists, skip it"
    fi
}
