#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

source "$(dirname ${BASH_SOURCE})"/../../framework/oo-bootstrap.sh

namespace macos
Log::AddOutput macos NOTE

# Binaries
binaries=(
    make
    libxml2
    libxslt
    libiconv
    gnupg
    dos2unix
    wget
    ctags
    grc
    git-flow
    mackup
    trash
    cheat
    watch
    colordiff
)

# Apps
apps=(
    alacritty       # 一个快速、跨平台的GPU驱动终端
    mos             # 平滑你的鼠标滚动效果或单独设置滚动方向
    hammerspoon     # mac 自动化工具，使用 lua 脚本实现各种功能
    maczip          # 免费的解压软件
    iina            # 播放器
    eazydict        # Translator
    orbstack        # mac docker alternative
    bleunlock       # bluetooth unlock
    loop            #s Window management made elegant.
    jordanbaird-ice # Powerful menu bar manager for macOS
    # xld # 音频转化
    # slate # 开源免费的桌面窗口控制调整工具
    # qlcolorcode
    # qlmarkdown
    # qlstephen
    # sequel-pro  # mysql客户端
    # sourcetree  # git 管理
    # movist  # 播放器
    # lingon-x # 启动项管理
    # xtrafinder # 加强finder
    # dash
    # flux
    # keka
    # kitematic
    # obs
    # recordit
    # slack
    # todoist
    # virtualbox
    # vlc
)

# Fonts
fonts=(
    font-hack-nerd-font
    font-caskaydia-cove-nerd-font
)

if ! Command::Exists brew; then
    Log "Installing Homebrew for you..."
    brew::setup
fi

Log "Update Homebrew..."
# Update homebrew recipes
brew update

Log "Installing coreutils, findutils, bash, macvim..."
# Install GNU core utilities (those that come with OS X are outdated)
brew::install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew::install findutils
# Install GNU `sed`
brew::install gnu-sed
# Install Bash 5
brew::install bash

Log "Installing binaries..."
brew::install "${binaries[@]}"

# echo "Installing fonts..."
# brew cask install ${fonts[@]}

# Important December 2015 update: Homebrew-Cask will now be kept up to date together with Homebrew (see #15381 for details).
# If you haven’t yet, run brew uninstall --force brew-cask; brew update to switch to the new system.

Log "Installing fonts..."
brew::install "${fonts[@]}"

# Install apps to /Applications
Log "Installing apps..."
brew::cask::install "${apps[@]}"

# clean things up
brew cleanup

exit 0
