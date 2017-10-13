#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

VERSION="2.4.2"

if ! command_exists rbenv; then
	if [[ $OS == "macos" ]]; then
		brew_install rbenv
	else
		git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
		cd $HOME/.rbenv && src/configure && make -C src
		export PATH="$HOME/.rbenv/bin:$PATH"

		# install ruby-build
		mkdir -p "$(rbenv root)"/plugins
		git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
	fi
	
	eval "$(rbenv init -)"

	rbenv install $VERSION

fi

if [[ ! $(rbenv versions | grep $VERSION) ]]; then
	rbenv install $VERSION -v
	rbenv global $VERSION
fi
