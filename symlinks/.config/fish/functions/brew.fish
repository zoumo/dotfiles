#!/usr/bin/env fish

function brew --wraps brew
    if test (uname -s) = Darwin
        set HOMEBREW_PREFIX /opt/homebrew
        $HOMEBREW_PREFIX/bin/brew $argv
        return
    end

    set -x HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -x HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
    set -x HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
    # sudo use -E to preserve-env
    # su use -p to preserve-env
    sudo -E su -p - linuxbrew bash -c "$HOMEBREW_PREFIX/bin/brew $argv"
end
