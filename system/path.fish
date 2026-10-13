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
    fish_add_path -gpm $ZEROBREW_PREFIX/opt/coreutils/libexec/gnubin
    fish_add_path -gpm $ZEROBREW_PREFIX/opt/findutils/libexec/gnubin
    fish_add_path -gpm $ZEROBREW_PREFIX/opt/gnu-sed/libexec/gnubin
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

# ====================================================================
# Go
# ====================================================================
if command_exists go
    set -gx GO111MODULE auto
end

# ====================================================================
# rust
# ====================================================================
if command_exists rustup
    # set rustup mirror
    set -gx RUSTUP_UPDATE_ROOT "https://mirrors.aliyun.com/rustup/rustup"
    set -gx RUSTUP_DIST_SERVER "https://mirrors.aliyun.com/rustup"
end

# ====================================================================
# python - uv (replaces pyenv)
# ====================================================================
if command_exists uv
    uv generate-shell-completion fish | source

    set -gx UV_PYTHON_INSTALL_MIRROR "https://gh-proxy.com/https://github.com/astral-sh/python-build-standalone/releases/download"
    # Python environment settings
    set -gx PYTHONDONTWRITEBYTECODE x

    # Auto-activate virtual environments via auto-uv-env
    if test -f (brew --prefix)/share/auto-uv-env/auto-uv-env.fish
        source (brew --prefix)/share/auto-uv-env/auto-uv-env.fish
    end
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


# ===================================================================
# Obsidian
# ===================================================================
if test -d /Applications/Obsidian.app
    fish_add_path -gpm /Applications/Obsidian.app/Contents/MacOS
end
if command_exists notesmd-cli
    notesmd-cli completion fish | source
end


# ====================================================================
# bun
# ====================================================================

if test -d $HOME/.bun
    fish_add_path -gpm $HOME/.bun/bin
end

# ====================================================================
# Skills Manager
# ====================================================================
if test -d $HOME/.skills-manager/bin
    fish_add_path -gpm $HOME/.skills-manager/bin
end

# ====================================================================
# atuin
# ====================================================================
if command_exists atuin
    atuin init fish --disable-up-arrow | source
end


# ====================================================================
# zellij
# ====================================================================
if command_exists zellij
    zellij setup --generate-completion fish | source
end
