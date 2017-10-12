#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

set -e

ROOT_PATH="$(dirname $(dirname $(dirname ${BASH_SOURCE})))"
source $ROOT_PATH/lib/lib.sh

# Binaries
binaries=(
  dos2unix
  wget
  ctags
  grc
  git-flow
  tree
  mackup
  # z
  htop
  trash
  cheat
  # hh      # https://github.com/dvorka/hstr
  fzf
  fasd
  # mysql
  # nginx
  # node
  # mongodb
  # boot2docker
  # docker
  # grc
  # hub
  # legit
  # nvm
  # ssh-copy-id
  # trash

)

# Apps
apps=(
  # java
  # google-chrome
  # qq
  # macdown  # markdown编辑器
  # iterm2 # 加强版终端
  scroll-reverser  # 可以分别鼠标和触控板滚动方向
  # goagentx  # FQ
  slate  # 开源免费的桌面窗口控制调整工具
  # qlcolorcode
  # qlmarkdown
  # qlstephen
  # beyond-compare  # 优秀的文件比较软件
  the-unarchiver  # 免费的解压软件
  # sequel-pro  # mysql客户端
  # clipmenu  # 粘贴版扩展 0.4.3
  # sourcetree  # git 管理
  # movist  # 播放器
  # lingon-x # 启动项管理
  xtrafinder  # 加强finder
  # mou
  # alfred
  # dash
  # evernote
  # flux
  # keka
  # kitematic
  # obs
  # recordit
  # slack
  # steam
  # sublime-text3
  # todoist
  # virtualbox
  # vlc
)

# Fonts
# fonts=(
#   font-roboto
#   font-source-code-pro
# )

echo "Update Homebrew..."
# Update homebrew recipes
# brew update

echo "Installing coreutils, findutils, bash, macvim..."
# Install GNU core utilities (those that come with OS X are outdated)
brew_install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew_install findutils
# Install GNU `sed`
brew_install_one --with-default-names gnu-sed
# Install Bash 4
brew_install bash
# To install useful keybindings and fuzzy completion
echo "y\n" | /usr/local/opt/fzf/install

echo "Installing binaries..."
brew_install ${binaries[@]}

# echo "Installing fonts..."
# brew cask install ${fonts[@]}

# Important December 2015 update: Homebrew-Cask will now be kept up to date together with Homebrew (see #15381 for details).
# If you haven’t yet, run brew uninstall --force brew-cask; brew update to switch to the new system.

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# clean things up
brew cleanup
brew cask cleanup

exit 0
