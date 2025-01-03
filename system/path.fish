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
# Golang
# ====================================================================
set -gx GVM_ROOT "$HOME/.gvm"
set -gx GO111MODULE auto

# ====================================================================
# Rust
# ====================================================================
if test -d $HOME/.cargo/bin
    fish_add_path -gpm $HOME/.cargo/bin
end

# ====================================================================
# python
# ====================================================================
# pyenv
if command_exists pyenv
    pyenv init - fish | source
    pyenv virtualenv-init - fish | source
end

if test (os_lsb_dist) = macos
    set -gx PYTHON_CONFIGURE_OPTS "--enable-framework CC=clang"
else
    set -gx PYTHON_CONFIGURE_OPTS "--enable-shared CC=clang"
end

set -gx PYTHONDONTWRITEBYTECODE x

# ====================================================================
# nodenv
# ====================================================================
if command_exists nodenv
    nodenv init - fish | source
end

# ====================================================================
# java
# ====================================================================
if command_exists jenv
    fish_add_path -gpm $HOME/.jenv/bin
    jenv init - fish | source
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
