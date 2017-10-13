#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname $BASH_SOURCE))"
source $ROOT_PATH/lib/lib.sh

VERSION="2.7.13"

if [[ $OS == "macos" ]]; then
	brew_install readline xz
elif [[ $OS == "centos" ]]; then
	yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
fi

# install pyenv
if [[ ! -d $HOME/.pyenv ]]; then
	curl -fsSL "https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer" | bash

	# temporary export
	export PYENV_ROOT="$HOME/.pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"

	# make cache
	mkdir -p $(pyenv root)/cache

fi

if [[ ! $(pyenv versions | grep $VERSION) ]]; then
	if [[ $OS == "macos" ]]; then
		env PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang" pyenv install $VERSION
	elif [[ $OS == "centos" ]]; then
		pyenv install $VERSION -v
	fi
	# set global version
	pyenv global $VERSION	
fi

# install plugins
plugins=(
	virtualenv
	autopep8
	flake8
	docopt
	pytz
	requests
	unittest2
    arrow
	thefuck
)

pyenv update

# update pip
pip_install_one --upgrade pip

pip_install ${plugins[@]}
