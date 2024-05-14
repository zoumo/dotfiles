<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Jim's dotfiles](#jims-dotfiles)
  - [What is dotfiles](#what-is-dotfiles)
  - [Compatibility](#compatibility)
- [Quick Start](#quick-start)
  - [Erase and reinstall macOS](#erase-and-reinstall-macos)
  - [Install Xcode](#install-xcode)
  - [Install dotfiles](#install-dotfiles)
  - [Restore backup](#restore-backup)
- [How To Use](#how-to-use)
  - [dotfiles](#dotfiles)
    - [Topical](#topical)
    - [Components](#components)
    - [流程](#流程)
  - [macOS](#macos)
    - [Homebrew packages](#homebrew-packages)
      - [Binaries](#binaries)
      - [Apps](#apps)
    - [macOS defaults setting](#macos-defaults-setting)
  - [Beautify](#beautify)
    - [Terminal/Iterm2](#terminaliterm2)
    - [ls](#ls)
  - [Mackup](#mackup)
  - [alias](#alias)
  - [Issue](#issue)
  - [Reference](#reference)
  - [Thanks](#thanks)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->



# Jim's dotfiles

## What is dotfiles

> The set of files used to describe session initialization procedures and store user customizations are commonly referred to as "dotfiles". These files can be used to customize screen appearance, shell behavior, program specifications and aspects of your Athena session. Most dotfiles are text files, although some exist in other formats. Dotfiles generally contain one command per line and are stored in your home directory. Dotfiles usually have names that begin with a period, hence the name dotfiles. You are given some dotfiles that are necessary for you to be able to login when you get your account.

![iMac-MacBook-flat](https://camo.githubusercontent.com/d3cade777e0e8da13097e79a1263f3b49bed2773/687474703a2f2f692e696d6775722e636f6d2f4742706a7248422e706e67)

这份 [dotfiles](https://github.com/zoumo/dotfiles) 是 fork 自 [Amowu's dotfiles](https://github.com/amowu/dotfiles) 基于 [Holman's dotfiles](https://github.com/holman/dotfiles)，并更加个人的需求进行了修改, 如果有兴趣欢迎fork一份回去配置适合自己的dotfiles。

更多的 dotfiles 请参考 [GitHub does dotfiles](https://dotfiles.github.io/)。

## Compatibility

-   macOS


-   CentOS7

# Quick Start

## Erase and reinstall macOS

如果你打算从干净的 Mac 环境开始，请参考「[OS X：如何清除并安装](http://support.apple.com/zh-tw/HT5943)」。

## Install Xcode

1. 安装或更新Xcode, 保证Xcode最新, 否则可能会导致失败
2. 安装Xcode Command Line Tools

``` bash
$ xcode-select --install
```

## Install dotfiles

使用 git clone 一份到 `$HOME` 目录底下的 `.dotfiles` 文件夹里面:

``` bash
$ git clone https://github.com/zoumo/dotfiles.git ~/.dotfiles
```

进入 `.dotfiles` 文件夹, 然后安装dotfiles:

``` bash
$ cd ~/.dotfiles

$ bash ./script/bootstrap
```

`bootstrap` 这个程序会自动完成以下的工作:

1. 检查并安装 [Oh My Zsh](http://ohmyz.sh/)。
2. 检查并链接 dotfiles (`.zshrc`)。
3. 系统相关：
    1. macOS
        1. 检查并安装 [Homebrew](http://brew.sh/)。
        2. 安装一些必要的软件和依赖。
        3. 设置 Mac OS X 的 defaults settings。
        4. 清理缓存
    2. CentOS7
        1. 安装源和依赖库
4. 语言环境 （python, ruby, go 作为基础依赖会优先安装）
    1. python: 使用 [pyenv](https://github.com/pyenv/pyenv) 管理 python 版本，安装一些基础库，很多其他工具都是基于 python，所以 python 会优先安装
    2. ruby: 使用 [rbenv](https://github.com/rbenv/rbenv.git) 管理 ruby 版本，目前是 [tmuxinator](https://github.com/tmuxinator/tmuxinator) 依赖 ruby
    3. go: golang 为我主要的工作语言
    4. nodejs
5. 安装 vim 和 tmux
6. 对 vim, ls, terminal 进行美化, 使用了 [one dark](https://github.com/nathanbuchar/atom-one-dark-terminal.git)
7. 切换 shell 到 zsh

## Restore backup

使用 [Mackup](https://github.com/lra/mackup) 进行备份恢复:

``` bash
$ mackup restore
```

> 什么是 Mackup? 下面会介紹。

# How To Use

## dotfiles

执行 `bash ~/.dotfiles/script/bootstrap` 的时候，脚本会将目录底下所有的 `*.symlink` 文件通过 `ln` 命令建立链接至 `$HOME` 目录底下:

| topic | *.symlink      | .dotfiles |
| ----- | -------------- | --------- |
| zsh   | zshenv.symlink | ~/.zshenv |
| zsh   | zshrc.symlink  | ~/.zshrc  |

>   我的 git 的 dotfiles 交给 mackup 来备份, vim 的 dotfiles 交给 [SpaceVim](https://github.com/SpaceVim/SpaceVim) 管理

### Topical

每一个环境的配置是以文件夹的形式独立区分, 例如, 如果想要增加 "Python" 的配置到 dotfiles, 则简单的新增一个名字为 `python` 的文件夹

任何后缀名是 `.zsh` 的文件将在 shell 执行时自动被载入环境中。

任何后缀名是 `.symlink` 的文件将在你执行 `script/bootstrap ` 的时候自动链接到 `$HOME` 目录下

### Components

目录中比较特殊的文件

- **bin/**: 任何在 `bin/` 目录下的文件可以在 shell 执行的时候使用。
- **topic/*.zsh**: 任何 `.zsh` 结尾的文件都会在 shell 执行的时候被载入环境。
- **topic/path.zsh**: 任何 `path.zsh` 文件会在 shell 执行时优先载入。
- **topic/*.symlink**: 任何 `*.symlink` 結尾的文件都会在 `$HOME` 目录下建立链接。

不同于 [Holman's dotfiles](https://github.com/holman/dotfiles)，我修改了一些部分:

- Shell 的部分改用 [Oh My Zsh](http://ohmyz.sh/) 取代原作者自己配置的 zsh。
- 移除 **topic/aliases.zsh**、**topic/completion.zsh** 等文件，改用 Oh My Zsh 的 [plugins]。(https://github.com/robbyrussell/oh-my-zsh/wiki/Plugins) 代替。
- 移除 **zsh/prompt.zsh**、**zsh/window.zsh** 等文件，改用 Oh My Zsh 的 [themes]。(https://github.com/robbyrussell/oh-my-zsh/wiki/Themes) 代替。
- dotfiles 只專注在 **topic/*.symlink**、**topic/path.zsh** 的配置已经环境的配置。

### 流程

`bin/dot` 会在 `script/bootstrap` 中执行, 负责安装 macOS 的程序和修改系统配置

执行 `$ dot` 之后，它会执行下面几个脚本:

1. `$HOME/.dotfiles/os/prepare.sh` 准备系统环境，判断运行操作系统，运行下面的两个脚本之一

    - `$HOME/.dotfiles/os/macos/*.sh`  安装 homebrew ，下载软件和依赖包，设置  macOS 的 defaults settings

    - `$HOME/.dotfiles/os/centos/install.sh` 安装 centos 源和依赖包

2. `$HOME/.dotfiles/python/install.sh` 使用 pyenv 安装 python

3. `$HOME/.dotfiles/ruby/install.sh` 使用 rbenv 安装 ruby

4. `$HOME/.dotfiles/go/install.sh` 安装 golang

5. `$HOME/.dotfiles/*/install.sh`  寻找其他含有 `install.sh` 的文件夹，逐个执行它

## macOS

### Homebrew packages

执行 `bash ./os/macos/install.sh` 的时候, 脚本会使用 [Homebrew](http://brew.sh/) 和 [Homebrew Cask](http://caskroom.io/) 來安裝 **binary**、**font** 還有 **app**，可以根据个人的需求增减packages的安装:

``` bash
binaries=(
  git
  tree
  ...
)
```

应用程序可以用 `$ brew cask search XXX` 或是 [Cask Search](http://caskroom.io/search) 网站搜索是否存在。

``` bash
apps=(
  scroll-reverser # 可以分别鼠标和触控板滚动方向
  slate # 开源免费的桌面窗口控制调整工具
  ...
)
```

以下是我目前自动安裝的 packages：

#### Binaries

| name                                                                             | info                                                                  |
| -------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| dos2unix                                                                         | 文档格式转换                                                          |
| wget                                                                             | wget 工具                                                             |
| ctags                                                                            | 方便代码阅读                                                          |
| [grc](http://kassiopeia.juls.savba.sk/~garabik/software/grc/README.txt)          | log 上色                                                              |
| [git-flow](https://github.com/nvie/gitflow)                                      | Git branch manage model                                               |
| [tree](http://mama.indstate.edu/users/ice/tree/)                                 | 树状目录结构显示                                                      |
| [mackup](https://github.com/lra/mackup)                                          | 同步应用程序配置                                                      |
| [z](https://github.com/rupa/z.git)                                               | autojump                                                              |
| tmux                                                                             | tmux                                                                  |
| htop                                                                             | 加强版 top                                                            |
| [trash](http://hasseg.org/blog/post/406/trash-files-from-the-os-x-command-line/) | 模拟 Finder 的移到废纸篓功能, 在 alias 中对 rm 进行替换, 进行安全删除 |
| [cheat](https://github.com/chrisallenlane/cheat)                                 | 命令示例 cheatsheets                                                  |

#### Apps

| name                                                    | info                                   |
| ------------------------------------------------------- | -------------------------------------- |
| the-unarchiver                                          | 优秀免费的解压软件                     |
| [scroll-reverser](http://pilotmoon.com/scrollreverser/) | 支持鼠标和触控板滚轮分别设置           |
| [slate](https://github.com/jigish/slate)                | Mac窗口调节程序,类似于Divvy and SizeUp |

### macOS defaults setting

执行 `bash ./os/macos/set-defaults.sh` 之后，程序会更改 macOS 的一些系统设置, 根据个人喜欢和需求修改这个文件，或是参考 [Mathias’s dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.osx) 整理好的配置。

以下是目前设定的配置：

| setting                                        | script                                                                                                         |
| ---------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| 关闭电源进入深度睡眠                           | `sudo pmset -a autopoweroff 0`                                                                                 |
| 加快窗口 resize 的速度(Cocoa applications)     | `defaults write NSGlobalDomain NSWindowResizeTime -float 0.001`                                                |
| 预设展开存储窗口(1)                            | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true`                                  |
| 预设展开存储窗口(2)                            | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true`                                 |
| 关闭“你确定要开启这个应用程序?"的询问窗口      | `defaults write com.apple.LaunchServices LSQuarantine -bool false`                                             |
| 加速进入睡眠模式                               | `sudo pmset -a hibernatemode 0`                                                                                |
| 开启触控板轻触点击功能(1)                      | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true`                        |
| 开启触控板轻触点击功能(2)                      | `defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1`                                |
| 开启触控板轻触点击功能(3)                      | `defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1`                                             |
| 开启触控板/滑鼠右键菜单功能(1)                 | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true`              |
| 开启触控板/滑鼠右键菜单功能(2)                 | `defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode "TwoButton"`                   |
| 开启触控板三指拖拽功能(1)                      | `defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -bool true`              |
| 开启触控板三指拖拽功能(2)                      | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true`         |
| 开启触控板四指下滑出现 app expose 功能(1)      | `defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 0`                  |
| 开启触控板四指下滑出现 app expose 功能(2)      | `defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0` |
| 开启触控板四指下滑出现 app expose 功能(3)      | `defaults write com.apple.dock showAppExposeGestureEnabled -int 1`                                             |
| 加快触控板/滑鼠的速度(1)                       | `defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3`                                              |
| 加快触控板/滑鼠的速度(2)                       | `defaults write NSGlobalDomain com.apple.mouse.scaling -int 3`                                                 |
| 开启全部窗口組件支持键盘控制                   | `defaults write NSGlobalDomain AppleKeyboardUIMode -int 3`                                                     |
| 关闭键盘按住的输入限制                         | `defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false`                                           |
| 加快键盘输入                                   | `defaults write NSGlobalDomain KeyRepeat -int 0`                                                               |
| 移除窗口截图的影子移除視窗截圖的影子           | `defaults write com.apple.screencapture disable-shadow -bool true`                                             |
| 显示隐藏文件                                   | `defaults write ~/Library/Preferences/com.apple.finder AppleShowAllFiles -bool true`                           |
| 预设Finder起始位置为下载(1)                    | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true`                                  |
| 预设Finder起始位置为下载(2)                    | `defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true`                                 |
| 显示所有拓展名                                 | `defaults write NSGlobalDomain AppleShowAllExtensions -bool true`                                              |
| 显示 Finder 状态栏                             | `defaults write com.apple.finder ShowStatusBar -bool true`                                                     |
| 显示 Finder 路径栏                             | `defaults write com.apple.finder ShowPathbar -bool true`                                                       |
| 允许框选 Finde Quick Look 的文字               | `defaults write com.apple.finder QLEnableTextSelection -bool true`                                             |
| 预设搜索的结果默认为当前的目录下               | `defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"`                                          |
| 关闭更改拓展名的警告提示                       | `defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false`                                   |
| 开启资料夹的 spring loading 功能               | `defaults write NSGlobalDomain com.apple.springing.enabled -bool true`                                         |
| 开启 Dock 的 spring loading 功能               | `defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true`                             |
| 移除 spring loading 的延迟                     | `defaults write NSGlobalDomain com.apple.springing.delay -float 0`                                             |
| 避免在 network volumes 底下建立 .DS_Store 档案 | `defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true`                                 |
| 使用 column view 作為 Finder 預設顯示選項      | `defaults write com.apple.finder FXPreferredViewStyle -string "clmv"`                                          |
| 将窗口最小化到应用程序图标                     | `defaults write com.apple.dock minimize-to-application -bool true`                                             |
| 在 Dock 中为打开的应用程序显示指示灯           | `defaults write com.apple.dock show-process-indicators -bool true`                                             |
| 关闭 Dashboard                                 | `defaults write com.apple.dashboard mcx-disabled -bool true`                                                   |
| 将 Dashboard 从多重桌面之中移除                | `defaults write com.apple.dock dashboard-in-overlay -bool true`                                                |
| 自动显示和隐藏dock                             | `defaults write com.apple.dock autohide -bool true`                                                            |
| 将隐藏的应用程序 Dock 图标用半透明显示         | `defaults write com.apple.dock showhidden -bool true`                                                          |

## Beautify

美化至少要对三个工具进行配色 Terminal, vim, ls, vim 使用了 SpaceVim 管理 vim 的方案

在 macOS 下使用了 atom-one-dark

在 CentOS 下使用了 solarized, 它提供了一套比较完整的解决方案, 但是作者没有给 ls 配色, 所以使用另外一个作者 [seebi](https://github.com/seebi/) 的 [dircolors-solarized](https://github.com/seebi/dircolors-solarized.git)

``` bash
$ git clone https://github.com/nathanbuchar/atom-one-dark-terminal.git ~/plugins
$ git clone https://github.com/altercation/solarized.git ~/plugins
$ git clone https://github.com/seebi/dircolors-solarized.git ~/plugins
```

### Terminal/Iterm2

```bash
# 导入iterm2的配色
$ open "~/plugins/atom-one-dark-terminal/scheme/iterm/One Dark.itermcolors"
# 导入Terminal.app的配色
$ open "~/plugins/atom-one-dark-terminal/scheme/terminal/One Dark.terminal"
```

### ls

macOS 是基于 FreeBSD 的, 所以 ls 是 BSD 那一套, 不是 GNU 的 ls, 所以即使Terminal/iTerm2 配置了颜色, 但是 ls 也不会受到影响, 所以通过安装 GNU 的 coreutils, 来解决

```shell
# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
eval `dircolors ~/plugins/dircolors-solarized/dircolors.ansi-dark`
```

## Mackup

当初始环境都安装好了以后, 就是需要备份了。除了 `.zsrc`、`.vimrc` 这类 dotfile 比较适合放置Github上面之外，其他像是 Sublime 的 plugin、iTerm2 的 setting、Oh My Zsh 的 plugin、等等很多一般程序的配置需要备份, 这些不适合放在Github上面。所以这里介紹 [Mackup](https://github.com/lra/mackup) 

**它将你想要备份的文件转移到 Dropbox , Google Drive, 百度云这样的云盘在本地的同步目录如 `~/dropbox/mackup`, 然后使用 `ln -s` 进行链接 `link -> ~/dropbox/mackup`**

install

``` bash
$ brew install mackup
```

配置方式也很容易，建立一份 `~/.mackup.cfg` 來修改:

``` bash
[storage]
engine = dropbox # 同步的云盘, 目前只有dropbox和google_drive可以选择
directory = Mackup # 同步的文件夹，这里会将所有的同步备份至 ~/Dropbox/Mackup 底下

# 指定要同步的应用程序
[applications_to_sync]
iterm2
oh-my-zsh
sublime-text-3
ssh

[applications_to_ignore]
# 指定不想同步的应用程序
```

还可以在 `~/.mackup`文件夹中添加自定义程序同步配置(注意, 如果自定义的配置与默认支持的程序同名, 会覆盖默认配置)

``` bash
$ vim ~/.mackup/sublime-text-3.cfg
[application]
name = Sublime Text 3

[configuration_files]
# Based on https://packagecontrol.io/docs/syncing
Library/Application Support/Sublime Text 3/Packages
Library/Application Support/Sublime Text 3/Installed Packages
.config/sublime-text-3/Packages/User
```

进行备份, 以后的任意修改都会被同步到云端

``` bash
$ mackup backup
```

就可以将文件备份到 Dropbox 或 Google Drive。需要恢复的适合则执行:

``` bash
$ mackup restore
```

以下是目前我备份的应用程序：

| app             | backup-conf                        |
| --------------- | ---------------------------------- |
| git             | ~/.gitconfig 和 .config/git/ignore |
| mackup          | ~/.mackup.cfg 和 ~/.mackup         |
| scroll-reverser | 默认配置                           |
| slate           | ~/.slate                           |
| sublime-text-3  | plugins 和 config                  |

更多详细的配置说明和支持软件请查看 [mackup 的文件](https://github.com/lra/mackup/tree/master/doc)。

## alias

由于个人习惯需要对一些命令进行alias, 如下

``` bash
alias dos2mac="dos2unix -c mac"
alias gbk2utf8="iconv -f GBK -t UTF-8"
alias utf82gbk="iconv -f UTF-8 -t GBK"
alias tailf="tail -f"
alias ve="pyenv local"
alias rm="trash" # 这个需要brew install trash
```

## Issue

其他的一些软件按需安装

| name                                                | 说明                                         |
| --------------------------------------------------- | -------------------------------------------- |
| [google-chrome](www.google.com/chrome)              | Google 浏览器                                |
| [Alacritty](https://github.com/alacritty/alacritty) | 一个快速、跨平台的 GPU 驱动终端              |
| [beyond-compare](http://www.scootersoftware.com/)   | Beyond Compare 是一个优秀的文件/目录对比工具 |
| [VSCode](https://code.visualstudio.com/)            | 我最喜欢的 Editor                            |
| Alfred                                              | workflow 神器                                |
| Dash                                                | API 查询神器                                 |
| Airmail2                                            | 漂亮的邮件客户端                             |
| MindNode Pro                                        | Simple and Beautiful Visual Brainstorming    |
| sequel-pro                                          | mysql client                                 |
| [Clipy](https://github.com/Clipy/Clipy)             | Clipboard extension app for macOS            |
| [Charles](http://www.charlesproxy.com/)             | 抓包工具                                     |
| movist                                              | 播放器                                       |



## Reference

- [Hacker's Guide to Setting up Your Mac](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac)
- [First steps with Mac OS X as a Developer](http://carlosbecker.com/posts/first-steps-with-mac-os-x-as-a-developer/)
- [Mac 开发配置手册](https://www.gitbook.com/book/aaaaaashu/mac-dev-setup/details)
- [如何優雅地在 Mac 上使用 dotfiles?](http://segmentfault.com/a/1190000002713879)
- [osx-for-hackers.sh](https://gist.github.com/brandonb927/3195465)
- [Mackup](https://github.com/lra/mackup/tree/master/doc)
- [我的 mac-dev-setup](https://github.com/zoumo/mac-dev-setup)

## Thanks

I forked [Amowu](https://github.com/amowu/)'s [dotfiles](https://github.com/amowu/dotfiles.git) base on [Zach Holman](http://github.com/holman)'s excellent [dotfiles](http://github.com/holman/dotfiles).
