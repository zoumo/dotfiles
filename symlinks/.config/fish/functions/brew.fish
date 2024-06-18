#!/usr/bin/env fish

function brew --wraps brew
    if test (uname -s) = Darwin
        if test (uname -m) = arm64
            set HOMEBREW_PREFIX /opt/homebrew
        else
            set HOMEBREW_PREFIX /usr/local
        end
    else
        set HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
        set HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
        set HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
    end

    $HOMEBREW_PREFIX/bin/brew $argv
end
