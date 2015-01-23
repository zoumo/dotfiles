# !/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Binaries
binaries=(
  grc
  mackup
  tree
)

# Apps
apps=(
  alfred
  dropbox
  google-chrome
  iterm2
  mou
  qlcolorcode
  qlmarkdown
  qlstephen
  sourcetree
  sublime-text3
)

# Fonts
fonts=(
  font-roboto
)

# Check for Homebrew
if test ! $(which brew)
then
  echo "Installing Homebrew for you..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /tmp/homebrew-install.log
fi

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
brew cask install --appdir="/Applications" ${apps[@]}

# clean things up
brew cleanup
brew cask cleanup

exit 0
