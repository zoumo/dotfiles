#!/bin/bash

source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

# Binaries
replacement=(
    # ls: A modern, maintained replacement for ls
    eza
    # cat: A cat(1) clone with syntax highlighting and Git integration.
    bat
    # du: A more intuitive version of du in rust
    dust
    # df: Disk Usage/Free Utility - a better 'df' alternative
    duf
    # cd: A smarter cd command.
    zoxide
    # find: A simple, fast and user-friendly alternative to 'find'
    fd
    # ps: A modern replacement for ps written in Rust
    procs
    # grep: ripgrep recursively searches directories for a regex pattern while respecting your gitignore
    ripgrep
)

utils=(
    # A command-line fuzzy finder
    fzf
    # The minimal, blazing-fast, and infinitely customizable prompt for any shell!
    starship
    # Interactive JSON filter using jq
    jnv # https://github.com/ynqa/jnv
    # a structural diff that understands syntax
    difftastic # https://github.com/Wilfred/difftastic
    # tldr: Collaborative cheatsheets for console commands
    tealdeer
    # control kubectl context
    kubectx
    # krew
    krew
    # A tool for exploring each layer in a docker image
    dive # https://github.com/wagoodman/dive
)

Log "Installing utils..."
brew::install "${replacement[@]}"
brew::install "${utils[@]}"
