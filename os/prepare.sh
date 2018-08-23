#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

namespace prepare
Log::AddOutput prepare NOTE

# prepare os
Log "$(OS::LSBDist) installing..."
bash ${DOT_ROOT}/os/$(OS::LSBDist)/install.sh
Log "$(OS::LSBDist) installation is complete"

if [[ $(OS::LSBDist) == "macos" ]]; then
	# Set OS X defaults
	Log "macos set-defaults"
	bash ${DOT_ROOT}/os/macos/set-defaults.sh
	Log "macos set-defaults"
fi
