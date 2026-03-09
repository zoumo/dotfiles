#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

namespace prepare
Log::AddOutput prepare NOTE

# prepare os
Log "$(OS::LSBDist) installing..."
bash "${DOT_ROOT}/os/$(OS::LSBDist)/install.sh"
Log "$(OS::LSBDist) installation is complete"

if os::macos; then
    # Set OS X defaults
    MARKER_FILE="$HOME/.local/share/dotfiles/.macos-defaults-applied"

    if [[ -f "$MARKER_FILE" && -z "$FORCE_MACOS_DEFAULTS" ]]; then
        Log "macos set-defaults already applied, skipping (set FORCE_MACOS_DEFAULTS=1 to force)"
    else
        Log "macos set-defaults"
        if bash "${DOT_ROOT}/os/macos/set-defaults.sh"; then
            mkdir -p "$(dirname "$MARKER_FILE")"
            touch "$MARKER_FILE"
            Log "macos set-defaults completed"
        else
            Log "macos set-defaults failed"
        fi
    fi
fi
