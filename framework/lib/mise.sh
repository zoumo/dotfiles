#!/bin/bash
import util/log
import util/command

namespace lib/mise
Log::AddOutput lib/mise STATUS

# Install mise via Zerobrew (idempotent)
# Note: 'mise use -g <tool>@<version>' auto-installs the tool
mise::setup() {
    if Command::Exists mise; then
        return 0
    fi

    Log "Installing mise via Zerobrew..."
    zerobrew::install mise

    # Verify installation
    if ! Command::Exists mise; then
        Log "mise: installation failed"
        return 1
    fi

    # Generate fish completions (non-fatal)
    mkdir -p ~/.config/fish/completions 2>/dev/null
    mise completions fish > ~/.config/fish/completions/mise.fish 2>/dev/null || true

    Log "mise $(mise --version 2>/dev/null | head -1) installed"
}
