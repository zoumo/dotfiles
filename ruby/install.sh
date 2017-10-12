#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

if [[ $OS == "macos" ]]; then
	brew_install ruby
elif [[ $OS == "centos" ]]; then
	sudo yum install -y ruby
fi
