#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source ${ROOT_PATH}/lib/init.sh

VERSION="2.4.2"

if ! util::command_exists rbenv; then
	if [[ ${OS} == "macos" ]]; then
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
