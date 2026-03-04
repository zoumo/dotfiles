<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [What is dotfiles](#what-is-dotfiles)
- [Jim's dotfiles](#jims-dotfiles)
- [Quick Start](#quick-start)
  - [Erase and reinstall macOS](#erase-and-reinstall-macos)
  - [Install Xcode](#install-xcode)
  - [Install dotfiles](#install-dotfiles)
- [细节说明](#细节说明)
  - [系统依赖初始化](#系统依赖初始化)
    - [macOS defaults setting](#macos-defaults-setting)
  - [终端美化](#终端美化)
    - [macos ls](#macos-ls)
  - [dotfiles](#dotfiles)
- [定制开发](#定制开发)
  - [基本工作原理](#基本工作原理)
  - [操作系统初始化逻辑](#操作系统初始化逻辑)
  - [Reference](#reference)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# What is dotfiles

The set of files used to describe session initialization procedures and store user customizations are commonly referred to as "dotfiles". These files can be used to customize screen appearance, shell behavior, program specifications and aspects of your Athena session. Most dotfiles are text files, although some exist in other formats. Dotfiles generally contain one command per line and are stored in your home directory. Dotfiles usually have names that begin with a period, hence the name dotfiles. You are given some dotfiles that are necessary for you to be able to login when you get your account.

# Jim's dotfiles

这份 [dotfiles](https://github.com/zoumo/dotfiles) 是最初是 fork 自 [Amowu's dotfiles](https://github.com/amowu/dotfiles) 基于 [Holman's dotfiles](https://github.com/holman/dotfiles)，后面根据个人的需求进行了大刀阔斧的修改，现在基本上已经跟原来的配置无关了


如果有兴趣欢迎 fork 一份回去配置适合自己的dotfiles。

更多的 dotfiles 请参考 [GitHub does dotfiles](https://dotfiles.github.io/)。

目前本 dotfiles 兼容以下的环境

-   macOS
-   linux
    -   debian - bookworm

最终在 macOS 下会得到以下的环境和工具

| Topic          | Value                                               |
| -------------- | --------------------------------------------------- |
| 包管理         | [Homebrew](https://brew.sh/)                        |
| 终端           | [alacritty](https://github.com/alacritty/alacritty) |
| vim            | [SpaceVim](https://spacevim.org/)                   |
| docker         | [OrbStack](https://orbstack.dev/)                   |
| 窗口控制       | [Loop](https://github.com/MrKai77/Loop)             |
| 状态栏管理工具 | [Ice](https://github.com/jordanbaird/Ice)           |
| go             | 1.22+                                               |
| python         | 3.11.9+                                             |
| Shell          | [fish](https://fishshell.com/)                      |



# Quick Start

## Erase and reinstall macOS

如果你打算从干净的 Mac 环境开始，请参考「[如何重新安装 macOS](https://support.apple.com/zh-cn/102655)」。

## Install Xcode

1. 安装或更新 Xcode, 保证 Xcode 最新, 否则可能会导致失败
2. 安装 Xcode Command Line Tools

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

1. 系统相关：
    1. macOS
        1. 检查并安装 [Homebrew](http://brew.sh/)。
        2. 安装一些必要的软件和依赖。
        3. 设置 Mac OS X 的 defaults settings。
        4. 清理缓存
    2. Linux
        1. 会安装一些系统依赖
2. 语言环境 （python, go, rust 作为基础依赖会优先安装）
    1. python: 使用 [pyenv](https://github.com/pyenv/pyenv) 管理 python 版本，安装一些基础库，很多其他工具都是基于 python，所以 python 会优先安装
    2. go: golang 为我主要的工作语言
    3. rust: rust 作为一门新兴的语言，我也会使用它来做一些小工具
    4. 还有一些其他的语言，比如 nodejs, java
3. 安装 fish, vim 和 tmux, 以及其他一些软件
4. 将 symlinks 下面的文件连接到 `$HOME`
5. 切换 shell 到 fish



# 细节说明

## 系统依赖初始化

对于 Linux 系统，首先会通过对应的发行版本的包管理器安装必要的软件，比如 git, curl 等还有运行 linuxbrew 必须的一些依赖

后续的二进制和包会都通过 `Homebrew/Linuxbrew` 来统一管理。

### macOS defaults setting

执行 `bash ./os/macos/set-defaults.sh` 之后，本程序会更改 macOS 的一些系统设置, 根据个人喜欢和需求修改这个文件，或是参考 [Mathias’s dotfiles](https://github.com/mathiasbynens/dotfiles/blob/master/.osx) 整理好的配置。

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

## 终端美化

本程序还会对以下三个工具进行配色 Terminal, vim, ls，其中 vim 使用了 SpaceVim 管理 vim 的方案

在 macOS 下使用了 atom-one-dark 的配色方案

在 linux 下使用了 solarized, 它提供了一套比较完整的解决方案，但是作者没有给 ls 配色所以采用另外一个作者 [seebi](https://github.com/seebi/) 的 [dircolors-solarized](https://github.com/seebi/dircolors-solarized.git)


### macos ls

我们默认安装的配色采用的 dircolors，这个只能影响到 GNU 的 ls，而 macOS 是基于 FreeBSD 的，并不会被上面的方案影响到，所以需要额外安装 GNU 的 coreutils 套件

```shell
brew install coreutils
```

## dotfiles

脚本在运行的时候会遍历 `symlinks` 目录，将目录下面所有的文件通 `ln` 创建软连接到 `$HOME` 的相对路径中

比如 symlinks 目录下面有一个文件 `.tmux.config.local`, 那么脚本会将这个文件软连接到 `$HOME/.tmux.config.local`


# 定制开发

本项目主要是使用 bash 的 shell 脚本开发，使用了 [bash-oo-framework](https://github.com/niieani/bash-oo-framework) 的 bash 框架

```shell
.
├── framework # bash-oo-framework 源代码
├── os        # 操作系统初始化相关逻辑
├── pkg       # 各个 topic 的目录
├── plugins   # 安装过程中下载内容的目录
├── script    # 项目入口
├── symlinks  # 软连接,所有文件都会链接到 $HOME 的相对路径下
```

## 基本工作原理

在本项目中，如果某个目录中带有 `install.sh` 的文件，那么这个目录被称为一天 topic 或者 module。


## 操作系统初始化逻辑

在开始构建环境之前通常需要对操作系统做一些初始化的工作，比如安装必要的依赖库和软件等

初始化的的逻辑入口在 `os/prepare.sh` 中，它会判断 os 的发行版，然后调用相应的脚本

## Reference

- [Hacker's Guide to Setting up Your Mac](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac)
- [First steps with Mac OS X as a Developer](http://carlosbecker.com/posts/first-steps-with-mac-os-x-as-a-developer/)
- [Mac 开发配置手册](https://www.gitbook.com/book/aaaaaashu/mac-dev-setup/details)
- [如何優雅地在 Mac 上使用 dotfiles?](http://segmentfault.com/a/1190000002713879)
- [osx-for-hackers.sh](https://gist.github.com/brandonb927/3195465)
- [Mackup](https://github.com/lra/mackup/tree/master/doc)
- [我的 mac-dev-setup](https://github.com/zoumo/mac-dev-setup)
