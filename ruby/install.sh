#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

VERSION="2.4.2"

if ! Command::Exists rbenv; then
	if [[ $(OS::LSBDist) == "macos" ]]; then
		util::brew_install rbenv
	else
		if [[ ! -d $HOME/.rbenv ]]; then
			git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
		fi

		cd $HOME/.rbenv && src/configure && make -C src
		export PATH="$HOME/.rbenv/bin:$PATH"

		# install ruby-build
		if [[ ! -d "$(rbenv root)"/plugins/ruby-build ]]; then
			mkdir -p "$(rbenv root)"/plugins
			git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
		fi
	fi
	eval "$(rbenv init -)"

fi

if [[ ! $(rbenv versions | grep $VERSION) ]]; then
	rbenv install $VERSION -v
fi

rbenv global $VERSION
