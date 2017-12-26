#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source ${ROOT_PATH}/lib/init.sh

# prepare os
log::status "${OS} installing"
bash ${DOT_ROOT}/os/${OS}/install.sh
log::status "${OS} install"

if [[ ${OS} == "macos" ]]; then
	# Set OS X defaults
	log::status "macos set-defaults"
	bash ${DOT_ROOT}/os/macos/set-defaults.sh
	log::status "macos set-defaults"
fi
