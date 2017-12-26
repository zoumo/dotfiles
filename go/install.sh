#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source ${ROOT_PATH}/lib/init.sh

if [[ ${OS} == "macos" ]]; then
	util::brew_install go mercurial
	# bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
elif [[ ${OS} == "centos" ]]; then
	sudo yum install -y golang
fi

exit 0
