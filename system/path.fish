#!/usr/bin/env fish

# set editor
set -gx EDITOR 'vim'

fish_add_path -gP $HOMEBREW_PREFIX/bin
fish_add_path -gP $HOMEBREW_PREFIX/sbin

# set up brew shell env
brew shellenv | source

set -gx HOMEBREW_API_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
set -gx HOMEBREW_BREW_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
set -gx HOMEBREW_CORE_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
set -gx HOMEBREW_PIP_INDEX_URL "https://pypi.tuna.tsinghua.edu.cn/simple"


# add path
fish_add_path -gP $DOTFILES/bin
fish_add_path -gP $HOME/bin

# set languange
set -gx LC_CTYPE en_US.UTF-8
set -gx LC_ALL en_US.UTF-8

set -gx OPT_PATH "/usr/local/opt"

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
    fish_add_path -gP $HOME/.cargo/bin
end

# ====================================================================
# python
# ====================================================================
# pyenv
if command_exists pyenv
    pyenv init - | source
    pyenv virtualenv-init - | source
end

if test (os_lsb_dist) = "macos"
    set -gx PYTHON_CONFIGURE_OPTS "--enable-framework CC=clang"
else
    set -gx PYTHON_CONFIGURE_OPTS "--enable-shared CC=clang"
end

set -gx PYTHONDONTWRITEBYTECODE x

# virtualenv config
set -gx VIRTUALENV_USE_DISTRIBUTE 1
set -gx VIRTUALENV_NO_SITE_PACKAGES 1

# ====================================================================
# nodenv
# ====================================================================
if command_exists nodenv
    nodenv init - | source
end

if command_exists yvm
    set -gx YVM_DIR $HOME/.yvm
    source /usr/local/bin/yvm.fish
end

# ====================================================================
# nodenv
# ====================================================================

if test (os_lsb_dist) = "macos"
    # For the system Java wrappers to find this JDK, symlink it with
    # sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
    # If you need to have openjdk first in your PATH, run:
    fish_add_path -gP /opt/homebrew/opt/openjdk/bin
    #For compilers to find openjdk you may need to set:
    set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk/include"
end


# ====================================================================
# krew
# ====================================================================
fish_add_path -gP $HOME/.krew/bin

# ====================================================================
# starship
# ====================================================================
if command_exists starship
    starship init fish | source
end

