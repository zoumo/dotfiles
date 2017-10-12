#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

if [[ $OS == "macos" ]]; then
	brew_install go mercurial
	# bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
elif [[ $OS == "centos" ]]; then
	sudo yum install -y golang
fi

exit 0
