#!/usr/bin/env fish

# set editor
set -gx EDITOR vim

# add path
fish_add_path -gpm $DOTFILES/bin
fish_add_path -gpm $HOME/bin

# set languange
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx OPT_PATH /usr/local/opt


# ====================================================================
# set gnu
# ====================================================================
if test (os_lsb_dist) = macos
    fish_add_path -gpm (brew --prefix coreutils)/libexec/gnubin
    fish_add_path -gpm (brew --prefix findutils)/libexec/gnubin
    fish_add_path -gpm (brew --prefix gnu-sed)/libexec/gnubin
end
# ====================================================================
# use clang
# ====================================================================
set -gx CC /usr/bin/clang
set -gx CXX /usr/bin/clang++

# ====================================================================
# mise - version manager for Go, Node.js, Java, Rust
# ====================================================================
if command_exists mise
    mise activate fish | source
end

# Go
set -gx GO111MODULE auto

# ====================================================================
# python - uv (replaces pyenv)
# ====================================================================

# Python environment settings
set -gx PYTHONDONTWRITEBYTECODE x

# Auto-activate virtual environments via auto-uv-env
if test -f (brew --prefix)/share/auto-uv-env/auto-uv-env.fish
    source (brew --prefix)/share/auto-uv-env/auto-uv-env.fish
end

# ====================================================================
# krew
# ====================================================================
fish_add_path -gpm $HOME/.krew/bin

# ====================================================================
# starship
# ====================================================================
if command_exists starship
    starship init fish | source
end

# ====================================================================
# zoxide
# ====================================================================
if command_exists zoxide
    zoxide init fish | source
end

# ====================================================================
# kubectl
# ====================================================================
if command_exists kubectl
    kubectl completion fish | source
    kubectl completion fish | sed -e "s/-c kubectl/-c k/g" | source
end

# ====================================================================
# orbstack
# ====================================================================
if command_exists orb
    orb completion fish | source
end

# ====================================================================
# helm
# ====================================================================
if command_exists helm
    helm completion fish | source
end

# ====================================================================
# pnpm
# ====================================================================
if command_exists pnpm
    set -gx PNPM_HOME "$HOME/.pnpm"
    fish_add_path -gpm $HOME/.pnpm
end
