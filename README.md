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
  - [工具选择理念](#%E5%B7%A5%E5%85%B7%E9%80%89%E6%8B%A9%E7%90%86%E5%BF%B5)
    - [Shell: Fish](#shell-fish)
    - [终端: Alacritty](#%E7%BB%88%E7%AB%AF-alacritty)
    - [Docker: OrbStack](#docker-orbstack)
    - [GNU 工具](#gnu-%E5%B7%A5%E5%85%B7)
    - [版本管理: mise](#%E7%89%88%E6%9C%AC%E7%AE%A1%E7%90%86-mise)
    - [Python: uv](#python-uv)
    - [编辑器: Neovim + LazyVim](#%E7%BC%96%E8%BE%91%E5%99%A8-neovim--lazyvim)
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

## 工具选择理念

为什么选择这些工具？以下是每个关键工具的选型理由。

### Shell: Fish

[Fish](https://fishshell.com/) (Friendly Interactive Shell) 是一个为用户友好设计的现代 shell：

- **开箱即用的自动补全**：无需复杂配置，Fish 提供强大的命令、参数和路径补全
- **语法高亮**：命令在输入时就会显示不同颜色，帮助识别语法错误
- **基于 Web 的配置界面**：通过 `fish_config` 可以在浏览器中配置主题和函数
- **简洁的脚本语法**：比 Bash 更直观，没有 POSIX 的历史包袱
- **与 Oh-My-Fish 配合**：提供插件生态和主题支持

> 唯一需要注意的是 Fish 不完全兼容 POSIX，一些 Bash 脚本可能需要调整。但日常使用中，Fish 的优势远大于这个限制。

### 终端: Alacritty

[Alacritty](https://alacritty.org/) 是一个使用 GPU 加速的现代终端模拟器：

- **极致性能**：利用 GPU 渲染，滚动和输出速度远超传统终端
- **最小化设计**：不内置标签页、分屏等功能，遵循 Unix 哲学——专注做一件事
- **配置简单**：使用 TOML/YAML 配置文件，无需 GUI 设置
- **跨平台**：macOS、Linux、Windows 都可用相同配置

> 为什么不用 iTerm2？iTerm2 功能丰富但臃肿，Alacritty 选择与 tmux 配合，性能更好。

### Docker: OrbStack

[OrbStack](https://orbstack.dev/) 是 macOS 上 Docker Desktop 的现代替代品：

- **启动速度**：秒级启动，Docker Desktop 需要数十秒
- **资源占用低**：内存占用仅为 Docker Desktop 的 1/3
- **原生网络**：无需端口转发，容器端口直接可用
- **无缝集成**：完全兼容 Docker CLI 和 docker-compose
- **额外功能**：内置 Linux 虚拟机和 Kubernetes 支持

> 对于开发者，OrbStack 带来的体验提升是革命性的——不再需要等待 Docker 启动，不再因为资源占用而卡顿。

### GNU 工具

macOS 的命令行工具来自 BSD，与 Linux (GNU) 有细微差异。安装 GNU 工具的原因：

- **跨平台脚本一致性**：编写能在 macOS 和 Linux 上运行的脚本
- **更丰富的功能**：GNU 工具通常有更多选项和扩展
- **脚本兼容性**：许多开源项目的构建脚本假设 GNU 环境

| GNU 工具 | 替代的 BSD 工具 | 主要差异 |
|----------|-----------------|----------|
| `coreutils` | BSD userland | `date -d`, `ls --color` 等 GNU 扩展 |
| `gnu-sed` | BSD sed | 支持 `-i` 直接修改文件（无需备份后缀）|
| `findutils` | BSD find | 更丰富的 `-exec` 语法和选项 |

> 通过在 PATH 中添加 GNU 工具前缀（如 `gdate`, `gsed`），可以同时保留两者，按需使用。

### 版本管理: mise

[mise](https://mise.jdx.dev/) (前身为 rtx) 是一个统一的多语言版本管理器：

- **统一管理**：一个工具管理 Go、Node.js、Rust、Java 等所有语言版本
- **兼容 asdf**：可以直接使用 asdf 插件生态
- **自动切换**：进入项目目录自动切换到配置的版本
- **速度快**：用 Rust 编写，比 asdf 快 10-100 倍
- **无需 shim**：直接操作 PATH，没有性能损耗

> 告别 nvm、pyenv、goenv、sdkman 等多个版本管理器，mise 一个就够了。

### Python: uv

[uv](https://docs.astral.sh/uv/) 是 Astral 公司用 Rust 编写的极速 Python 工具：

- **安装速度**：比 pip 快 10-100 倍
- **统一工具链**：替代 pip、pip-tools、pipx、poetry、pyenv、virtualenv
- **自动虚拟环境**：运行脚本自动创建和管理 venv
- **项目管理**：内置依赖解析和 lock 文件支持
- **工具安装**：`uv tool install` 替代 pipx

> 为什么不用 pyenv？uv 安装 Python 的速度比 pyenv 快很多，而且它还能管理依赖和虚拟环境，一站式解决所有 Python 开发需求。

### 编辑器: Neovim + LazyVim

[Neovim](https://neovim.io/) 是 Vim 的现代分支，[LazyVim](https://www.lazyvim.org/) 是一个预配置的 Neovim 发行版：

- **启动速度快**：Lua 配置比 VimScript 快得多
- **LSP 原生支持**：内置语言服务器协议，无需插件即可获得智能补全
- **Tree-sitter**：更精准的语法高亮和代码理解
- **LazyVim 开箱即用**：预配置了 LSP、格式化、Git、文件树等常用功能
- **插件生态**：使用 lazy.nvim 插件管理器，延迟加载，按需安装

> 为什么不用 VS Code？Neovim + LazyVim 提供了 VS Code 级别的功能，但保持了 Vim 的键盘操作效率。一旦适应，编码速度会显著提升。

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
