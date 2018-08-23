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
	libxml2
	libxslt
	libiconv
	gnupg
	dos2unix
	wget
	ctags
	grc
	git-flow
	tree
	mackup
	htop
	trash
	cheat
	# mysql
	# nginx
	# node
	# mongodb
	# grc
	# hub
	# legit
	# ssh-copy-id

)

# Apps
apps=(
	scroll-reverser # 可以分别鼠标和触控板滚动方向
	slate # 开源免费的桌面窗口控制调整工具
	# qlcolorcode
	# qlmarkdown
	# qlstephen
	the-unarchiver # 免费的解压软件
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
# fonts=(
#   font-roboto
#   font-source-code-pro
# )

if ! Command::Exists brew; then
	Log "Installing Homebrew for you..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

Log "Update Homebrew..."
# Update homebrew recipes
brew update

Log "Installing coreutils, findutils, bash, macvim..."
# Install GNU core utilities (those that come with OS X are outdated)
util::brew_install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
util::brew_install findutils
# Install GNU `sed`
util::brew_install_one gnu-sed --with-default-names
# Install Bash 4
util::brew_install bash

Log "Installing binaries..."
util::brew_install ${binaries[@]}

# echo "Installing fonts..."
# brew cask install ${fonts[@]}

# Important December 2015 update: Homebrew-Cask will now be kept up to date together with Homebrew (see #15381 for details).
# If you haven’t yet, run brew uninstall --force brew-cask; brew update to switch to the new system.

# Install apps to /Applications
Log "Installing apps..."
util::brew_cask_install ${apps[@]}

# clean things up
brew cleanup

exit 0
