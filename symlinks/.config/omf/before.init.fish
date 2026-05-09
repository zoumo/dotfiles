#!/usr/bin/env fish

# clean path
# set -gx PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin

# set dotfiles path
set -gx DOTFILES $HOME/.dotfiles

# ============================================================
# brew
# ============================================================
# setup brew prefix temporarily to let fish find brew
if test (uname -s) = Darwin
    if test (uname -m) = arm64
        set -x HOMEBREW_PREFIX /opt/homebrew
    else
        set -x HOMEBREW_PREFIX /usr/local
    end
else 
    set -x HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
    set -x HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
    set -x HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
end

set -x ZEROBREW_PREFIX /opt/zerobrew

# Add homebrew bin path to $PATH directly, it will be the first item in $PATH now.
# Then PATH may be orther shell init scripts such as gvm, pyenv, these shims paths will be prepended before brew bin paths.
# Finally, $fish_user_paths will be prepended to $PATH.
# The order of $PATH is:
# 1. $fish_user_paths
# 2. gvm, pyenv, nodenv shims
# 3. zerobrew bin. homebrew bin, homebrew sbin
# 4. original $PATH

# set up hombrew shell env
# export HOMEBREW_PREFIX HOMEBREW_CELLAR HOMEBREW_REPOSITORY
# add HOMEBREW_PREFIX/bin and HOMEBREW_PREFIX/sbin to PATH
brew shellenv | source

# preappend zerobrew bin before homebrew bin in PATH
fish_add_path -gpmP $ZEROBREW_PREFIX/bin

# mirror: aliyun
# set -gx HOMEBREW_API_DOMAIN "https://mirrors.aliyun.com/homebrew-bottles/api"
# set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.aliyun.com/homebrew-bottles"
# set -gx HOMEBREW_PIP_INDEX_URL "http://mirrors.aliyun.com/pypi/simple"
# set -gx HOMEBREW_BREW_GIT_REMOTE "https://mirrors.aliyun.com/homebrew/brew.git"
# set -gx HOMEBREW_CORE_GIT_REMOTE "https://mirrors.aliyun.com/homebrew/homebrew-core.git"

# mirror tsinghua
set -gx HOMEBREW_API_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
set -gx HOMEBREW_PIP_INDEX_URL "https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple"
# set -gx HOMEBREW_BREW_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
# set -gx HOMEBREW_CORE_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
