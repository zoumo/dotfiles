#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

VERSION="2.4.1"

if ! command_exists rvm; then
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL https://get.rvm.io | bash -s stable

	if [[ $OS == "macos" ]]; then
		source $HOME/.rvm/scripts/rvm
	elif [[ $OS == "centos" ]]; then	
		source /etc/profile.d/rvm.sh
	fi
	rvm install $VERSION 
fi

rvm use $VERSION --default
