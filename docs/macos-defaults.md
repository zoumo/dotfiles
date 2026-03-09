# macOS Defaults Settings

## Overview

Running `bash ./os/macos/set-defaults.sh` will change some macOS system settings. Modify this file according to your preferences, or refer to [Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.osx) for more configuration options.

## Settings List

| Setting | Script |
|---------|--------|
| Disable power-related deep sleep | `sudo pmset -a autopoweroff 0` |
| Speed up window resize (Cocoa applications) | `defaults write NSGlobalDomain NSWindowResizeTime -float 0.001` |
| Expand save panel by default (1) | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true` |
| Expand save panel by default (2) | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true` |
| Disable "Are you sure you want to open this application?" dialog | `defaults write com.apple.LaunchServices LSQuarantine -bool false` |
| Speed up entering sleep mode | `sudo pmset -a hibernatemode 0` |
| Enable trackpad tap to click (1) | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true` |
| Enable trackpad tap to click (2) | `defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1` |
| Enable trackpad tap to click (3) | `defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1` |
| Enable trackpad/mouse right-click menu (1) | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true` |
| Enable trackpad/mouse right-click menu (2) | `defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode "TwoButton"` |
| Enable trackpad three-finger drag (1) | `defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true` |
| Enable trackpad three-finger drag (2) | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true` |
| Enable four-finger swipe down for App Expose (1) | `defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0` |
| Enable four-finger swipe down for App Expose (2) | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0` |
| Enable four-finger swipe down for App Expose (3) | `defaults write com.apple.dock showAppExposeGestureEnabled -int 1` |
| Speed up trackpad/mouse tracking (1) | `defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3` |
| Speed up trackpad/mouse tracking (2) | `defaults write NSGlobalDomain com.apple.mouse.scaling -int 3` |
| Enable full keyboard access for all controls | `defaults write NSGlobalDomain AppleKeyboardUIMode -int 3` |
| Disable press-and-hold for keys | `defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false` |
| Speed up keyboard repeat | `defaults write NSGlobalDomain KeyRepeat -int 0` |
| Remove shadow from window screenshots | `defaults write com.apple.screencapture disable-shadow -bool true` |
| Show hidden files | `defaults write ~/Library/Preferences/com.apple.finder AppleShowAllFiles -bool true` |
| Set Finder default location to Downloads (1) | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true` |
| Set Finder default location to Downloads (2) | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true` |
| Show all file extensions | `defaults write NSGlobalDomain AppleShowAllExtensions -bool true` |
| Show Finder status bar | `defaults write com.apple.finder ShowStatusBar -bool true` |
| Show Finder path bar | `defaults write com.apple.finder ShowPathbar -bool true` |
| Enable text selection in Quick Look | `defaults write com.apple.finder QLEnableTextSelection -bool true` |
| Set default search scope to current folder | `defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"` |
| Disable extension change warning | `defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false` |
| Enable spring loading for folders | `defaults write NSGlobalDomain com.apple.springing.enabled -bool true` |
| Enable spring loading for Dock items | `defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true` |
| Remove spring loading delay | `defaults write NSGlobalDomain com.apple.springing.delay -float 0` |
| Avoid creating .DS_Store on network volumes | `defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true` |
| Use column view as Finder default | `defaults write com.apple.finder FXPreferredViewStyle -string "clmv"` |
| Minimize windows into application icon | `defaults write com.apple.dock minimize-to-application -bool true` |
| Show indicator lights for open applications in Dock | `defaults write com.apple.dock show-process-indicators -bool true` |
| Disable Dashboard | `defaults write com.apple.dashboard mcx-disabled -bool true` |
| Remove Dashboard from Mission Control | `defaults write com.apple.dock dashboard-in-overlay -bool true` |
| Auto-hide Dock | `defaults write com.apple.dock autohide -bool true` |
| Make hidden apps' Dock icons semi-transparent | `defaults write com.apple.dock showhidden -bool true` |

## Reference

- [Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.osx)