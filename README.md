# Amo Wu does dotfiles

如果不清楚什麼是 dotfiles 的話，可以參閱[善用 dotfiles 個人化自己的工作環境](http://cloudchen.logdown.com/posts/49264746647/dotfiles):

> dotfiles，顧名思義，就是檔案名稱以 . (dot) 為 prefix 的檔案通稱，若是您的作業系統是 Mac OS X 或是 Linux 這類 *nix-based 的作業系統，一般來說在視窗環境中是看不到這些檔案的，因為對系統來說，他們是所謂的隱藏檔，這些檔案有一些共通點，那就是他們通常用來儲存一些個人化的設定或是自定的拓展功能，以符合使用者本身的使用需求與習慣，有了這些設定好的檔案之後，使用者可以讓整個系統用起來更為順手，並且大幅提昇他們自身的工作效率！因此對某些使用者來說，這些 dotfiles 設定檔對他們來說，反而可能是他們機器上最重要的檔案呢！

![心智圖](http://2.bp.blogspot.com/-fFPbZGT8PcQ/VNxKxQHte6I/AAAAAAAAgKQ/NPVbkNiAoVs/s1600/f4ec16b6f72031d99b0b0d40af57126ec06967d68b78ed45b4afa4ab7ff4038f%2B(2).png)

這份 dotfiles 是 fork 自[Holman's dotfiles](https://github.com/holman/dotfiles)，並根據個人的需求修改過，如果有興趣，閱讀完這份文件之後，歡迎 fork 一份回去配置成適合自己的 dotfiles。

更多的 dotfiles 請參考[GitHub does dotfiles](https://dotfiles.github.io/)。

---

- [Quick Start](#quick-start)
  - [清除並安裝 OS X](#erase-and-reinstall-os-x)
  - [安裝 Xcode](#install-xcode)
  - [安裝 dotfiles](#install-dotfiles)
  - [恢復備份](#restore-backup)
- [How To Use](#how-to-use)
  - [dotfiles](#dotfiles)
  - [OS X](#os-x)
  - [Mackup](#mackup)
- [Issue](#issue)
  - [App Store](#app-store)

# Quick Start

## Erase and reinstall OS X

如果你打算從乾淨的 Mac 環境開始，請參閱 [OS X：如何清除並安裝](http://support.apple.com/zh-tw/HT5943)。

## Install Xcode

1. 更新 App Store。
2. 安裝 [Xcode](https://itunes.apple.com/us/app/xcode/id497799835?mt=12)。
3. 開啟 Terminal，安裝 Xcode Command Line Tools:

```sh
xcode-select --install
```

## Install dotfiles

[下載](https://github.com/amowu/dotfiles/archive/master.zip)或使用 git clone 一份到 `$HOME` 目錄底下的 `.dotfiles` 資料夾裡面:

```sh
git clone https://github.com/amowu/dotfiles.git ~/.dotfiles
```

進入 `.dotfiles` 資料夾:

```sh
cd ~/.dotfiles
```

安裝 dotfiles:

```sh
script/bootstrap
```

`bootstrap.sh` 這個程式會自動完成以下工作:

1. 檢查並安裝 [Homebrew](http://brew.sh/)。
2. 檢查並安裝 [Oh My Zsh](http://ohmyz.sh/)。
3. 檢查並連結 dotfiles(`.zshrc`, `.vimrc`, `.gitconfig`,` .gitignore`, ...)。
4. 更新並安裝 brew packages(binaries, fonts, apps)。
5. 設置 Mac OS X 的 defaults settings。

完成之後，手動安裝一些 App Store 上才有的軟體(Dash, Moom, ...)。

## Restore backup

使用 [Mackup](https://github.com/lra/mackup) 進行備份回復:

```sh
mackup restore
```

什麼是 Mackup? 底下會介紹。

---

# How To Use

## dotfiles

執行 `~/.dotfiles/script/bootstrap` 的時候，腳本會將目錄底下所有的 `*.symlink` 檔案透過 `ln` 命令建立連結至 `$HOME` 目錄底下:

| topic  | *.symlink          | .dotfiles     |
| ------ | ------------------ | ------------- |
| git    | gitconfig.symlink  | ~/.gitconfig  |
|        | gitignore.symlink  | ~/.gitignore  |
| mackup | mackup.cfg.symlink | ~/.mackup.cfg |
| vim    | vimrc.symlink      | ~/.vimrc      |
| zsh    | zshrc.symlink      | ~/.zshrc      |

### Topical

每一個環境的配置是以資料夾的形式被獨立區分。例如，如果想要新增 "Java" 的配置到 dotfiles，你可以簡單的新增一個命名為 `java` 的資料夾，然後將檔案建至目錄底下。
任何副檔名是 `.zsh` 的檔案將在 shell 執行時被自動載入至環境中。
任何副檔名是 `.symlink`的檔案將在你執行 `script/bootstrap` 安裝時被連結至 `$HOME` 目錄底下。.

### Components

一些目錄中比較特別的檔案:

- **bin/**: 任何在 `bin/` 目錄底下的檔案可以在 shell 執行時直接使用。
- **topic/*.zsh**: 任何 `.zsh` 結尾的檔案都會在 shell 執行時被載入至環境。
- **topic/path.zsh**: 任何命名為 `path.zsh` 的檔案會在 shell 執行時優先被載入至 `$PATH`。
- **topic/*.symlink**: 任何 `*.symlink` 結尾的檔案都會在 `$HOME` 目錄底下建立連結。這可以讓你在配置環境的時候也保持版本控制的優點。新增 symlink 的時候需要執行 `script/bootstrap` 安裝。

不同於 [Holman's dotfiles](https://github.com/holman/dotfiles)，我修改了一些部分:

- Shell 的部分改用 [Oh My Zsh](http://ohmyz.sh/)取代原作者自己配置的 zsh。
- 移除 **topic/aliases.zsh**、**topic/completion.zsh** 等檔案，改用 Oh My Zsh 的 [plugins]。(https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins) 代替。
- 移除 **zsh/prompt.zsh**、**zsh/window.zsh.zsh** 等檔案，改用 Oh My Zsh 的 [themes]。(https://github.com/robbyrussell/oh-my-zsh/wiki/Themes) 代替。
- dotfiles 只專注在 **topic/*.symlink**、**topic/path.zsh** 的配置。

## OS X

`bin/dot` 是一支簡單的腳本，會在 `script/bootstrap` 配置完 dotfiles 之後執行，安裝自定的 OS X 程式並設定系統參數配置。

執行 `dot` 之後，它會跑以下兩支腳本檔:

1. `$HOME/.dotfiles/homebrew/install.sh` - Homebrew packages
2. `$HOME/.dotfiles/osx/set-defaults.sh` - OS X defaults setting

### Homebrew packages

執行 `homebrew/install.sh` 的時候，腳本會使用 [Homebrew](http://brew.sh/) 和 [Homebrew Cask](http://caskroom.io/) 來安裝 **binary**、**font** 還有 **app**，可以根據個人需求修改這個檔案，增加或減少自己需要的 packages:

```sh
binaries=(
  git
  tree
  ...
)
```

字型都是以 **font-XXX** 的形式命名，可以用 `brew cask search /font-XXX/` 搜尋是否存在。

```sh
fonts=(
  font-roboto
  ...
)
```

應用程式可以用 `brew cask search XXX` 或是 [Cask Search](http://caskroom.io/search) 網站搜尋是否存在。

```sh
apps=(
  dropbox
  google-chrome
  ...
)
```

以下是目前安裝的 packages:

| Binary | 說明 |
| --- | --- |
| [boot2docker](https://github.com/nvie/gitflow) |  Linux virtual machine provider |
| [docker](https://github.com/nvie/gitflow) | An open platform for distributed applications for developers and sysadmins. |
| [git-flow](https://github.com/nvie/gitflow) | Git branch manage model |
| [grc](http://kassiopeia.juls.savba.sk/~garabik/software/grc/README.txt) | log 上色 |
| [hub](https://github.com/github/hub) | hub is a command-line wrapper for git that makes you better at GitHub |
| [legit](http://www.git-legit.org/) | optimized for Git command-line |
| [mackup](https://github.com/lra/mackup) | 同步應用程式的配置 |
| [nvm](https://github.com/creationix/nvm) | Node Version Manager |
| ssh-copy-id | install your public key in a remote machine’s authorized_keys |
| [trash](http://mama.indstate.edu/users/ice/tree/) | 樹狀目錄顯示 |
| [tree](http://hasseg.org/trash/) | 刪除至垃圾桶 |

| Font | 說明 |
| --- | --- |
| [font-roboto](http://www.google.com/fonts/specimen/Roboto) | Roboto |
| [font-source-code-pro](http://www.google.com/fonts/specimen/Source+Code+Pro) | Source Code Pro |

| App | 說明 |
| --- | --- |
| [alfred](http://www.alfredapp.com/) | 三大神器之一 |
| [dash](http://kapeli.com/dash) | 程式文件查詢 |
| [dropbox](http://www.dropbox.com/) | 雲端硬碟 |
| [evernote](https://evernote.com/) | 筆記 |
| [flux](https://justgetflux.com/) | 螢幕色彩亮度調整 |
| [google-chrome](www.google.com/chrome) | Google 瀏覽器 |
| [iterm2](http://iterm2.com/) | 加強版終端機 |
| [Kaleidoscope](http://www.kaleidoscopeapp.com/) | File comparison for Mac |
| [Keka](http://www.kekaosx.com/) | 免費的Mac OS X 檔案壓縮程式 |
| [MacDown](http://macdown.uranusjr.com/) | Open source Markdown editor for OS X |
| [OBS](https://obsproject.com/) | Free, open source software for live streaming and recording |
| [qlcolorcode](https://code.google.com/p/qlcolorcode/) | 讓 Quick Look 支援 syntax highlighting |
| [qlmarkdown](https://github.com/toland/qlmarkdown) | 讓 Quick Look 支援 Markdown |
| [qlstephen](http://whomwah.github.io/qlstephen/) | 讓 Quick Look 支援無副檔名的純文字檔 |
| [qq](http://im.qq.com/macqq/) | 聊天 |
| [Recordit](http://recordit.co/) | Record screencasts fast with GIF |
| [sourcetree](http://www.sourcetreeapp.com/) | Git GUI |
| [sublime-text3](http://www.sublimetext.com/3) | 程式碼編輯器 |
| [virtualbox](https://www.virtualbox.org/) | 虛擬機 |
| [VLC](www.videolan.org/vlc) | 媒體播放器 |

### OS X defaults setting

執行 `osx/set-defaults.sh` 之後，程式會將 Mac OS X 的一些系統設置改變，可以根據個人需求修改這個檔案，或是參考 [Mathias’s dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.osx) 整理好的配置。

以下是目前設定的配置:

| setting | script |
| ------ | --- |
| 關閉電池進入深入睡眠模式 | sudo pmset -a standby 0 |
| 關閉電源進入深入睡眠模式 | sudo pmset -a autopoweroff 0 |
| 加快視窗 resize 的速度(Cocoa applications) | defaults write NSGlobalDomain NSWindowResizeTime -float 0.001 |
| 預設展開儲存視窗 | defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true |
|| defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true |
| 關閉“你確定要開啟這個應用程式?”詢問視窗 | defaults write com.apple.LaunchServices LSQuarantine -bool false |
| 關閉 Time Machine | sudo tmutil disablelocal |
| 加速進入睡眠模式 | sudo pmset -a hibernatemode 0 |
| 開啟觸控板輕觸點擊功能 | defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true |
|| defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 |
|| defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1 |
| 開啟觸控板/滑鼠右鍵選單功能 | defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true |
|| defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode "TwoButton" |
| 開啟觸控板三指拖曳功能 | defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true |
|| defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true |
| 開啟觸控板四指向下滑出現 app expose 功能 | defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0 |
|| defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0 |
|| defaults write com.apple.dock showAppExposeGestureEnabled -int 1 |
| 加快觸控板/滑鼠的速度 | defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3 |
|| defaults write NSGlobalDomain com.apple.mouse.scaling -int 3  |
| 開啟全部視窗組件支援鍵盤控制 | defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 |
| 關閉鍵盤按住的輸入限制 | defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false |
| 加快鍵盤輸入 | defaults write NSGlobalDomain KeyRepeat -int 0 |
| 移除視窗截圖的影子 | defaults write com.apple.screencapture disable-shadow -bool true |
| 預設 Finder 起始位置為下載資料夾 | defaults write com.apple.finder NewWindowTarget -string "PfLo" |
|| defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/" |
| 顯示副檔名 | defaults write NSGlobalDomain AppleShowAllExtensions -bool true |
| 顯示 Finder 狀態列 | defaults write com.apple.finder ShowStatusBar -bool true |
| 顯示 Finder 路徑列 | defaults write com.apple.finder ShowPathbar -bool true |
| 允許框選 Finde Quick Look 的文字 | defaults write com.apple.finder QLEnableTextSelection -bool true |
| Finder 標題列顯示完整路徑 | defaults write com.apple.finder _FXShowPosixPathInTitle -bool true |
| 預設搜尋列的結果為當前目錄下 | defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" |
| 關閉改變副檔名的警告提示 | defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false |
| 開啟資料夾的 spring loading 功能 | defaults write NSGlobalDomain com.apple.springing.enabled -bool true |
| 開啟 Dock 的 spring loading 功能 | defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true |
| 移除 spring loading 的延遲 | defaults write NSGlobalDomain com.apple.springing.delay -float 0 |
| 避免在 network volumes 底下建立 .DS_Store 檔案 | defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true |
| 使用 column view 作為 Finder 預設顯示選項 | defaults write com.apple.finder FXPreferredViewStyle -string "clmv" |
| 關閉清空垃圾桶的警告提示 | defaults write com.apple.finder WarnOnEmptyTrash -bool false |
| 使用黑色的選單列和 Dock | defaults write NSGlobalDomain AppleInterfaceStyle Dark |
| 使用縮放的效果作為視窗放大縮小效果 | defaults write com.apple.dock mineffect -string "scale" |
| 應用程式縮小至自己的圖示 | defaults write com.apple.dock minimize-to-application -bool true |
| 顯示 Dock 應用程式開啟中的小亮燈提示 | defaults write com.apple.dock show-process-indicators -bool true |
| 關閉 Dock 開啟應用程式的彈跳動畫 | defaults write com.apple.dock launchanim -bool false |
| 加快 Mission Control 的動畫速度 | defaults write com.apple.dock expose-animation-duration -float 0.1 |
| 關閉 Mission Control 的應用程式群組化顯示 | defaults write com.apple.dock expose-group-by-app -bool false |
| 關閉 Dashboard | defaults write com.apple.dashboard mcx-disabled -bool true |
| 將 Dashboard 從多重桌面之中移除 | defaults write com.apple.dock dashboard-in-overlay -bool true | 
| 自動隱藏 Dock | defaults write com.apple.dock autohide -bool true |
| 移除隱藏 Dock 的延遲 | defaults write com.apple.dock autohide-delay -float 0 |
| 移除 Dock 的顯示/隱藏動畫 | defaults write com.apple.dock autohide-time-modifier -float 0 |
| 將隱藏的應用程式 Dock 圖示半透明顯示 | defaults write com.apple.dock showhidden -bool true |

以上，若修改過 `homebrew/install.sh` 或 `osx/set-defaults.sh` 之後，直接執行指令:

```sh
dot
```

就會再次更新 packages 還有 defaults setting。

## Mackup

當初始環境都安裝好之後，剩下的就是恢復備份。除了 `.zsrc`、`.vimrc` 這類 dotfile 比較適合放在版本控制之外，其他像是 Sublime 的 plugin、iTerm2 的 setting、Oh My Zsh 的 plugin、等等很多還有一般應用程式的配置檔需要備份，甚至是 SSH 的 key，這些我認為都不適合丟進 dotfiles 放上 GitHub。所以這裡介紹 [Mackup](https://github.com/lra/mackup) 這個簡單的工具作為解決方案，使用方式很簡單，`brew install mackup` 安裝完之後只要執行:

```
mackup backup
```

就可以將檔案備份到 Dropbox 或 Google Drive。當需要恢復的時候則是執行:

```
mackup restore
```

就會將雲端硬碟上的備份以 `ln` 連結的方式在新電腦上同步。

配置方式也很容易，建立一份 `~/.mackup.cfg`，或是直接使用 `.dofiles/mackup/mackup.cfg.symlink` 來修改:

```sh
[storage]
engine = dropbox # 同步的雲端硬碟，有 dropbox 與 google_drive 可以選擇
directory = Mackup # 同步的資料夾，這裡會將所有備份同步至 ~/Dropbox/Mackup 底下

# 指定要同步的應用程式
[applications_to_sync]
iterm2
oh-my-zsh
sublime-text-3
ssh

[applications_to_ignore]
# 指定不想同步的應用程式
```

以下是目前備份的應用程式:

| app | 說明 |
| --- | --- |
| [aws](https://aws.amazon.com/tw/cli/) | AWS Command Line Interface |
| [dash](http://kapeli.com/dash) | 程式文件查詢 |
| [flux](https://justgetflux.com/) | 螢幕色彩亮度調整 |
| [iterm2](http://iterm2.com/) | 加強版終端機 |
| [moom](http://manytricks.com/moom/) | 視窗布局 |
| [oh-my-zsh](http://ohmyz.sh/) | 加強版 ZSH |
| [sourcetree](http://www.sourcetreeapp.com/) | Git GUI |
| [sublime-text-3](http://www.sublimetext.com/) | 程式碼編輯器 |
| ssh | SSH Key |

更多詳細的配置與支援的軟體請參閱 [mackup 的文件](https://github.com/lra/mackup/tree/master/doc)。

# Issue

## App Store

剩下無法透過 Homebrew 安裝，或是需要透過 App Store 購買的應用程式，只能手動一個一個安裝回來了...

以下是目前安裝的應用程式:

| App | 說明 |
| --- | --- |
| [Moom](http://manytricks.com/moom/) | 視窗布局 |
| [Day One](http://dayoneapp.com/) | 日記 |
| [LINE](http://line.me/) | 聊天 |
| Microsoft Remote Desktop | 遠端桌面 |

其他安裝方式的應用程式:

| App | 說明 |
| --- | --- |
| [Affinity Photo](https://affinity.serif.com/photo/) beta | 修圖軟體 |
| [Yahoo!奇摩輸入法](https://github.com/yahoo/keykey) beta | 输入法 |

---

## 參考文章

- [Hacker's Guide to Setting up Your Mac](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac)
- [First steps with Mac OS X as a Developer](http://carlosbecker.com/posts/first-steps-with-mac-os-x-as-a-developer/)
- [Mac 开发配置手册](https://www.gitbook.com/book/aaaaaashu/mac-dev-setup/details)

## Bugs

If you're brand-new to the project and run into any blockers, please [open an issue](https://github.com/holman/dotfiles/issues) on this repository and I'd love to get it fixed for you!

## Thanks

I forked [Zach Holman](http://github.com/holman)'s excellent [dotfiles](http://github.com/holman/dotfiles).
