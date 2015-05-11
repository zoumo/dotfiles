# !/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Binaries
binaries=(
  boot2docker
  docker
  git-flow
  grc
  hub
  legit
  mackup
  nvm
  ssh-copy-id
  trash
  tree
)

# Apps
apps=(
  alfred
  dash
  dropbox
  evernote
  flux
  google-chrome
  iterm2
  kaleidoscope
  keka
  macdown
  obs
  qlcolorcode
  qlmarkdown
  qlstephen
  qq
  recordit
  sourcetree
  sublime-text3
  virtualbox
  vlc
)

# Fonts
fonts=(
  font-roboto
  font-source-code-pro
)

echo "Update Homebrew..."
# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils
# Install Bash 4
brew install bash
# Install Homebrew Cask
brew tap caskroom/fonts
brew tap caskroom/versions
brew install caskroom/cask/brew-cask

echo "Installing binaries..."
brew install ${binaries[@]}

echo "Installing fonts..."
brew cask install ${fonts[@]}

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing apps..."
sudo brew cask install --appdir="/Applications" ${apps[@]}

# clean things up
brew cleanup
brew cask cleanup

exit 0
