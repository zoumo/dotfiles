#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

DOT_ROOT="$(cd "$(dirname "${BASH_SOURCE}")/.." && pwd -P)"
source "${DOT_ROOT}/lib/logging.sh"
source "${DOT_ROOT}/lib/util.sh"

log::install_errexit

source "${DOT_ROOT}/lib/os.sh"

# ====================================================================

plugins=${DOT_ROOT}/plugins

if [[ ! -d ${plugins} ]]; then
	mkdir ${plugins}
fi
