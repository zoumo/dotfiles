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

# Add homebrew bin path to $PATH directly, it will be the first item in $PATH now.
# Then PATH may be orther shell init scripts such as gvm, pyenv, these shims paths will be prepended before brew bin paths.
# Finally, $fish_user_paths will be prepended to $PATH.
# The order of $PATH is:
# 1. $fish_user_paths
# 2. gvm, pyenv, nodenv shims
# 3. brew bin, brew sbin
# 4. original $PATH
fish_add_path -gpmP $HOMEBREW_PREFIX/bin
fish_add_path -gpmP $HOMEBREW_PREFIX/sbin

# set up brew shell env
brew shellenv | source

set -gx HOMEBREW_API_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
set -gx HOMEBREW_BOTTLE_DOMAIN "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"
set -gx HOMEBREW_BREW_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
set -gx HOMEBREW_CORE_GIT_REMOTE "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
set -gx HOMEBREW_PIP_INDEX_URL "https://pypi.tuna.tsinghua.edu.cn/simple"

