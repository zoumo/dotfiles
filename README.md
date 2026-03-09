<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [什么是 dotfiles](#%E4%BB%80%E4%B9%88%E6%98%AF-dotfiles)
- [zoumo 的 dotfiles](#zoumo-%E7%9A%84-dotfiles)
- [快速开始](#%E5%BF%AB%E9%80%9F%E5%BC%80%E5%A7%8B)
  - [兼容性说明](#%E5%85%BC%E5%AE%B9%E6%80%A7%E8%AF%B4%E6%98%8E)
  - [MacOS 前置准备](#macos-%E5%89%8D%E7%BD%AE%E5%87%86%E5%A4%87)
  - [安装 dotfiles](#%E5%AE%89%E8%A3%85-dotfiles)
- [特性](#%E7%89%B9%E6%80%A7)
  - [安装内容概览](#%E5%AE%89%E8%A3%85%E5%86%85%E5%AE%B9%E6%A6%82%E8%A7%88)
    - [Homebrew 二进制工具](#homebrew-%E4%BA%8C%E8%BF%9B%E5%88%B6%E5%B7%A5%E5%85%B7)
    - [macOS 应用 (Homebrew Cask)](#macos-%E5%BA%94%E7%94%A8-homebrew-cask)
    - [字体](#%E5%AD%97%E4%BD%93)
  - [MacOS 默认配置修改](#macos-%E9%BB%98%E8%AE%A4%E9%85%8D%E7%BD%AE%E4%BF%AE%E6%94%B9)
  - [语言工具版本管理](#%E8%AF%AD%E8%A8%80%E5%B7%A5%E5%85%B7%E7%89%88%E6%9C%AC%E7%AE%A1%E7%90%86)
  - [现代工具替换](#%E7%8E%B0%E4%BB%A3%E5%B7%A5%E5%85%B7%E6%9B%BF%E6%8D%A2)
  - [配置文件链接](#%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6%E9%93%BE%E6%8E%A5)
  - [Shell 别名](#shell-%E5%88%AB%E5%90%8D)
  - [环境变量](#%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F)
  - [安装目录](#%E5%AE%89%E8%A3%85%E7%9B%AE%E5%BD%95)
  - [开发指南](#%E5%BC%80%E5%8F%91%E6%8C%87%E5%8D%97)
- [常见问题](#%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98)
    - [如何更新工具版本？](#%E5%A6%82%E4%BD%95%E6%9B%B4%E6%96%B0%E5%B7%A5%E5%85%B7%E7%89%88%E6%9C%AC)
- [参考](#%E5%8F%82%E8%80%83)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# zoumo's dotfiles

## 什么是 dotfiles

Dotfiles 是用于自定义开发环境的配置文件——包括 shell 设置、编辑器偏好、工具配置等。之所以叫 "dotfiles"，是因为它们通常以点开头的文件名（如 `.bashrc`、`.gitconfig`），在 Unix 系统中是隐藏文件。

# 快速开始

## 兼容性说明

本 dotfiles 目前支持以下环境：

- macOS
- linux: 目前只尝试过 debian - bookworm

## MacOS 前置准备

如果你想从干净的 Mac 环境开始，请参阅"[如何重装 macOS](https://support.apple.com/zh-cn/102655)"。

**安装 Xcode**

1. 安装或更新 Xcode 到最新版本，否则安装可能会失败
2. 安装 Xcode Command Line Tools

``` bash
$ xcode-select --install
```

## 安装 dotfiles

克隆仓库到 `$HOME/.dotfiles`：

```bash
git clone https://github.com/zoumo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# 完整安装（默认）- 安装所有基础和附加包
bash ./script/bootstrap

# 最小安装 - 只安装基础包，跳过附加包
DOT_MODE=mini bash ./script/bootstrap

# 强制重置 macOS 默认设置（默认只运行一次）
FORCE_MACOS_DEFAULTS=1 bash ./script/bootstrap
```

> **注意**: 安装完成后会自动将默认 shell 切换为 fish。

# 特性

## 安装内容概览

安装完成后，你的系统将包含以下内容：

- **语言工具**: Go, Node.js, Rust, Python, Java (通过 mise/uv 管理)
- **Shell**: fish + Oh-My-Fish + starship 提示符
- **终端**: Alacritty (GPU 驱动的现代终端)
- **编辑器**: Neovim + LazyVim 配置
- **Docker**: OrbStack (macOS 上的 Docker 替代品)
- **窗口管理**: Loop (优雅的窗口管理工具)
- **状态栏**: Ice (macOS 菜单栏管理器)

<details>
<summary>点击展开完整软件包列表</summary>

### Homebrew 二进制工具

**GNU 核心工具**:
- coreutils, findutils, gnu-sed, bash

**开发工具**:
- make, libxml2, libxslt, libiconv, gnupg, wget, ctags, grc, git-flow

**实用工具**:
- mackup, trash, cheat, watch, colordiff, fx, tesseract, dos2unix

**现代替代工具**:
- eza (ls), bat (cat), dust (du), duf (df), zoxide (cd), fd (find), procs (ps), ripgrep (grep)

**开发辅助**:
- fzf, starship, jnv, difftastic, tealdeer, kubectx, krew, dive, switcher

### macOS 应用 (Homebrew Cask)

- alacritty - GPU 驱动的跨平台终端
- mos - 平滑鼠标滚动
- maczip - 免费解压软件
- iina - 现代播放器
- eazydict - 翻译工具
- orbstack - Docker 替代品
- bleunlock - 蓝牙解锁
- loop - 窗口管理
- jordanbaird-ice - 菜单栏管理

### 字体

- font-hack-nerd-font
- font-caskaydia-cove-nerd-font

</details>

## MacOS 默认配置修改

自动修改以下的系统默认配置 [macOS 默认设置](docs/macos-defaults.md)

## 语言工具版本管理

| 工具 | 管理工具 | 说明 |
|------|----------|------|
| Go | [mise](https://mise.jdx.dev/) | 阿里云镜像 |
| Node.js | [mise](https://mise.jdx.dev/) | 清华镜像 |
| Rust | [mise](https://mise.jdx.dev/) | 阿里云 rustup 镜像 |
| Java | [mise](https://mise.jdx.dev/) | 通过 Homebrew 安装 |
| Python | [uv](https://docs.astral.sh/uv/) | 极速安装、自动激活虚拟环境、清华 PyPI 镜像 |

## 现代工具替换

用现代替代品替换传统命令：

| 传统命令 | 现代替代品 | 描述 |
|-------------|-------------------|-------------|
| ls | [eza](https://github.com/eza-community/eza) | 带颜色和图标 |
| cat | [bat](https://github.com/sharkdp/bat) | 带语法高亮 |
| find | [fd](https://github.com/sharkdp/fd) | 更快的 find |
| grep | [ripgrep](https://github.com/BurntSushi/ripgrep) | 更快的 grep |
| du | [dust](https://github.com/bootandy/dust) | 更直观的 du |
| df | [duf](https://github.com/muesli/duf) | 更美观的 df |
| ps | [procs](https://github.com/dalance/procs) | 现代 ps |
| top | [btop](https://github.com/aristocratos/btop) | 更美观的 top |
| cd | [zoxide](https://github.com/ajeetdsouza/zoxide) | 智能目录跳转 |

## 配置文件链接

<details>
<summary>点击展开配置文件清单</summary>

安装时会创建以下软链接：

| 文件路径 | 用途 |
|----------|------|
| `~/.config/.gitconfig` | Git 全局配置 |
| `~/.config/starship.toml` | Starship 提示符配置 |
| `~/.config/alacritty/alacritty.toml` | Alacritty 终端配置 |
| `~/.config/fish/functions/` | Fish shell 自定义函数 |
| `~/.config/omf/init.fish` | Oh-My-Fish 初始化配置 |
| `~/.config/omf/before.init.fish` | Fish 启动前配置 |
| `~/.config/smug/zoumo.yml` | Tmux 会话管理配置 |
| `~/.kube/switch-config.yaml` | kubectl context 切换配置 |
| `~/.tmux.conf.local` | Tmux 本地配置 |
| `~/.mvnvm.properties` | Maven 版本管理配置 |

</details>

## Shell 别名

<details>
<summary>点击展开别名列表</summary>

| 别名 | 命令 | 说明 |
|------|------|------|
| ls | eza | 现代化 ls |
| la | eza -glhA | 显示隐藏文件和详情 |
| tree | eza -T -L3 | 树形显示目录 |
| cat | bat | 语法高亮 cat |
| top | btop | 现代化 top |
| rm | trash | 安全删除（仅 macOS）|
| vi | nvim | 使用 Neovim |
| vim | nvim | 使用 Neovim |
| fcd | _fzf_search_directory | fzf 目录搜索 |
| fps | _fzf_search_processes | fzf 进程搜索 |
| fh | _fzf_search_history | fzf 历史搜索 |
| fgl | _fzf_search_git_log | fzf Git 日志搜索 |
| jv | fx | JSON 查看器 |
| yv | fx --yaml | YAML 查看器 |
| mux | smug start zoumo | 启动 tmux 会话 |

</details>

## 开发指南

参考 [开发指南](docs/development-guide.md) 

# 常见问题

### 如何更新工具版本？

使用 mise 管理版本：

```bash
mise ls              # 查看已安装版本
mise install go@1.25 # 安装特定版本
mise use go@1.25     # 设置项目版本
```


# 参考

- [Hacker's Guide to Setting up Your Mac](http://lapwinglabs.com/blog/hacker-guide-to-setting-up-your-mac)
- [First steps with Mac OS X as a Developer](http://carlosbecker.com/posts/first-steps-with-mac-os-x-as-a-developer/)
- [Mac Development Setup Guide](https://www.gitbook.com/book/aaaaaashu/mac-dev-setup/details)
- [Mackup](https://github.com/lra/mackup/tree/master/doc)
- [My mac-dev-setup](https://github.com/zoumo/mac-dev-setup)
