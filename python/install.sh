#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

VERSION="3.6.5"

if [[ $(OS::LSBDist) == "macos" ]]; then
	util::brew_install readline xz
elif [[ $(OS::LSBDist) == "centos" ]]; then
	yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
fi

# install pyenv
if ! Command::Exists pyenv; then
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
	if [[ $(OS::LSBDist) == "macos" ]]; then
		env PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang" pyenv install $VERSION
	elif [[ $(OS::LSBDist) == "centos" ]]; then
		env PYTHON_CONFIGURE_OPTS="--enable-shared CC=clang" pyenv install $VERSION -v
	fi
fi

# set global version
pyenv global $VERSION

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
util::pip_install_one --upgrade pip

util::pip_install ${plugins[@]}
