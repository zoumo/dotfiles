#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace python
Log::AddOutput python NOTE

GLOBAL_VERSION="3.11.9"
VERSIONS=(${GLOBAL_VERSION})

# prerequisite is needed
# if [[ $(OS::LSBDist) == "centos" ]]; then
#     sudo yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
# elif [[ $(OS::LSBDist) == "debian" ]]; then
#     sudo apt-get install -y make build-essential zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git
# fi

if os::macos; then
    brew::install readline sqlite xz zlib openssl@1.1
else
    brew::install bzip2 libffi libxml2 libxmlsec1 readline sqlite xz zlib openssl@1.1
fi

brew::install pyenv pyenv-virtualenv pyenv-ccache

brew::shellenv

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

for VERSION in ${VERSIONS[@]}; do
    if [[ ! $(pyenv versions | grep ${VERSION}) ]]; then
        Log "Installing python ${VERSION}"
        if os::macos; then
            # fixed, do not change me
            env CONFIGURE_OPTS="--enable-framework CC=clang" pyenv install ${VERSION} -v
        else
            reg='^2\.'
            if [[ ${VERSION} =~ ${reg} ]]; then
                # deprecated python2
                subject=WARN Log "python2 is deprecated now"
                # else
                # use openssl 1.1 for python3
                # export LD_LIBRARY_PATH="$(brew --prefix openssl@1.1)/lib:$(brew --prefix readline)/lib:$(brew --prefix zlib)/lib"
                # export LIBRARY_PATH="$(brew --prefix openssl@1.1)/include:$(brew --prefix readline)/include:$(brew --prefix zlib)/include"
            fi
            env CONFIGURE_OPTS="--enable-shared CC=clang" pyenv install ${VERSION} -v
        fi
    fi
done

# set global version
pyenv global ${GLOBAL_VERSION}

# install plugins
# plugins=(
#     # virtualenv
#     autopep8
#     flake8
#     docopt
#     pytz
#     requests
#     unittest2
#     arrow
#     thefuck
#     neovim
# )

# update pip
util::pip_install_one --upgrade pip
# use mirror
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# util::pip_install ${plugins[@]}
