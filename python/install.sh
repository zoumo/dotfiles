#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source ${ROOT_PATH}/lib/init.sh

VERSION="3.6.5"

if [[ ${OS} == "macos" ]]; then
	util::brew_install readline xz
elif [[ ${OS} == "centos" ]]; then
	yum install -y gcc zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel
fi

# install pyenv
if ! util::command_exists pyenv; then
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
	if [[ ${OS} == "macos" ]]; then
		env PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang" pyenv install $VERSION
	elif [[ ${OS} == "centos" ]]; then
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
