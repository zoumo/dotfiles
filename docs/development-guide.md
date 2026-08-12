# 开发指南

## 代码结构

```
.
├── bin/              # 自定义脚本（git_sync, mkcd 等）
├── framework/        # bash-oo-framework 框架
│   └── lib/          # 项目封装的库函数
│       ├── global.sh   # 全局变量（DOT_ROOT, DOT_PLUGINS, DOT_CACHE）
│       ├── brew.sh     # Homebrew/Zerobrew 安装与镜像配置
│       ├── mise.sh     # mise 版本管理器封装
│       ├── git.sh      # Git 克隆工具函数
│       ├── util.sh     # 通用工具函数
│       ├── semver.sh   # 语义版本比较
│       └── system.sh   # 系统相关函数
├── os/               # 操作系统初始化
│   ├── prepare.sh      # OS 初始化入口
│   ├── macos/          # macOS 专用配置
│   │   ├── install.sh    # Homebrew/Zerobrew 及常用软件安装
│   │   └── set-defaults.sh
│   └── debian/         # Debian 专用配置
├── pkg/              # 包安装脚本
│   ├── basic/          # 基础包（go, python, rust, nodejs, vim, fish, tools）
│   └── additional/     # 附加包（docker, java, zellij, tmux, alacritty）
├── plugins/          # 安装过程中下载的内容
├── script/           # 入口脚本
│   ├── bootstrap     # 主安装入口
│   ├── dot           # 包安装逻辑
│   └── linkfile      # 配置文件链接
├── symlinks/         # 配置文件软链接源
│   └── .config/       # 应用配置（nvim, fish, starship 等）
└── system/           # Fish shell 配置
    ├── alias.fish     # 别名定义
    └── path.fish      # 环境变量与工具激活
```

## 安装运行逻辑

### 整体安装流程

```
script/bootstrap
    │
    ├─→ script/dot
    │       │
    │       ├─→ os/prepare.sh
    │       │       └─→ os/{macos|debian}/install.sh  # 安装系统依赖、Homebrew 和 Zerobrew
    │       │
    │       ├─→ pkg/basic/{lang}/install.sh  # 先安装语言（python, go, rust）
    │       │
    │       ├─→ pkg/basic/{other}/install.sh # 再安装其他基础包
    │       │
    │       └─→ pkg/additional/*/install.sh  # 非最小模式时安装附加包
    │
    └─→ script/linkfile  # 创建配置文件软链接
```

### 安装入口：`script/bootstrap`

1. 加载 bash-oo-framework 框架
2. 设置安装模式（`DOT_MODE=full|mini`）
3. 依次执行 `script/dot` 和 `script/linkfile`
4. 将默认 shell 切换为 fish

### 包安装逻辑：`script/dot`

1. **OS 准备**：调用 `os/prepare.sh` 安装系统依赖
2. **语言优先**：先安装 `python`, `go`, `rust`（确保编译工具链可用）
3. **基础包**：安装 `pkg/basic` 下其他 topic
4. **附加包**：非最小模式时安装 `pkg/additional` 下 topic

### 配置链接：`script/linkfile`

遍历 `symlinks/` 目录，将所有文件软链接到 `$HOME` 对应位置。

## Fish Shell 加载逻辑

Fish 通过 Oh-My-Fish (OMF) 启动，加载顺序：

```
~/.config/omf/before.init.fish
    │
    ├─→ 设置 DOTFILES 环境变量
    ├─→ 配置 Homebrew/Zerobrew 路径和镜像
    └─→ 设置 brew/zb 环境变量

~/.config/omf/init.fish
    │
    ├─→ system/path.fish     # 环境变量、工具激活（mise, uv, starship 等）
    └─→ system/alias.fish    # 命令别名
```

**关键文件说明**：

| 文件 | 作用 |
|------|------|
| `before.init.fish` | Fish 启动前执行，配置 brew、zb 和镜像 |
| `init.fish` | 加载 `system/path.fish` 和 `system/alias.fish` |
| `path.fish` | 工具激活（mise, uv, starship, zoxide 等） |
| `alias.fish` | 命令别名（ls→eza, cat→bat 等） |

## Topic 开发

### 什么是 Topic

`pkg/` 目录下每个包含 `install.sh` 的子目录称为一个 **topic**。安装时会自动发现并执行其中的 `install.sh`。

### Topic 目录结构

```
pkg/basic/go/
└── install.sh    # 必须存在，安装入口
```

### 创建新 Topic

1. 在 `pkg/basic/` 或 `pkg/additional/` 下创建目录
2. 创建 `install.sh` 脚本
3. 编写幂等的安装逻辑

### install.sh 模板

```bash
#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace mytopic
Log::AddOutput mytopic NOTE

# 幂等检查：已安装则跳过
if Command::Exists mytool; then
    Log "mytool already installed, skipping"
    exit 0
fi

# 安装逻辑：普通 CLI 工具优先使用 Zerobrew
zerobrew::install mytool
# 或
mise::setup
mise use -g "mytool@1.0.0"

Log "mytool installed"
```

## 代码规范

### 框架加载

每个脚本必须先加载框架：

```bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh
```

路径深度根据脚本位置调整：
- `pkg/basic/go/install.sh` → `../../../framework/`
- `script/bootstrap` → `../framework/`

### 命名空间与日志

```bash
namespace mytopic              # 声明命名空间
Log::AddOutput mytopic NOTE    # 设置日志级别（NOTE/STATUS/DEBUG）

Log "Installing something..."  # 打印日志
```

### 幂等性要求

`install.sh` 必须幂等，多次执行结果一致：

```bash
# ✅ 正确：检查后安装
if ! Command::Exists mise; then
    zerobrew::install mise
fi

# ✅ 正确：使用封装好的幂等函数
zerobrew::install go rust node  # 普通 CLI 工具，内部已做检查
homebrew::cask::install firefox iterm2  # macOS GUI 应用，逐个检查后安装
homebrew::tap::install oven-sh/bun/bun  # tap formula，先 tap 再安装

# ❌ 错误：直接安装（会重复安装）
brew install go
```

### 库函数说明

#### brew.sh

```bash
brew::setup                         # 安装 Homebrew 和 Zerobrew
brew::mirror                        # 设置 Homebrew 清华镜像
brew::unmirror                      # 取消 Homebrew 镜像设置
homebrew::install <pkg>...          # 幂等安装必须走 Homebrew 的普通包
homebrew::tap::install <tap/pkg>... # 幂等安装 tap formula，如 oven-sh/bun/bun
homebrew::cask::install <app>...    # 幂等安装 macOS GUI 应用或字体
zerobrew::install <pkg>...          # 幂等安装普通 CLI 工具，默认优先使用
```

普通命令行工具优先使用 `zerobrew::install`，例如 `fish`、`neovim`、`zellij`、`uv`、`coreutils` 等。只有在以下场景使用 Homebrew 封装：

- `homebrew::cask::install`：安装 macOS GUI 应用、字体或只能通过 cask 分发的包。
- `homebrew::tap::install`：安装第三方 tap 中的 formula，传入完整 formula 名，函数会自动把前两段识别为 tap。例如 `oven-sh/bun/bun` 会先 tap `oven-sh/bun`，再安装 `bun`。
- `homebrew::install`：安装必须走 Homebrew core 的普通 formula。

#### mise.sh

```bash
mise::setup              # 幂等安装 mise
```

#### util.sh

```bash
util::find_installer <dir>  # 查找目录下所有 topic
os::macos                  # 判断是否为 macOS
util::pip_install <pkg>...  # 通过 uv 幂等安装 Python 包
util::pip_install_one <pkg> [args...]  # 安装单个 Python 包
util::link_file <src> <dst>  # 交互式创建软链接
```

#### git.sh

```bash
git::clone <url> <dir>   # 浅克隆仓库（已存在则跳过）
```

#### global.sh（自动加载）

```bash
$DOT_ROOT      # 项目根目录
$DOT_PLUGINS   # plugins 目录路径
$DOT_CACHE     # 缓存目录 ~/.cache/dotfiles
```

### 导入库函数

```bash
import lib/brew    # 导入 brew.sh
import lib/mise    # 导入 mise.sh
import lib/util    # 导入 util.sh
import lib/git     # 导入 git.sh
import util/log    # 导入日志功能
import util/command  # 导入 Command::Exists
import util/os     # 导入 OS::LSBDist
import Array/Contains  # 导入数组操作
```

### 常用工具函数

```bash
Command::Exists <cmd>    # 检查命令是否存在
OS::LSBDist              # 获取系统类型（macos/debian）
OS::Arch                 # 获取 CPU 架构（arm64/x86_64）
Array::Contains <item> <array>  # 检查数组是否包含元素
```

## 定制开发

### 添加别名

编辑 `system/alias.fish`：

```fish
alias myalias="my command"
```

### 添加环境变量

编辑 `system/path.fish`：

```fish
set -gx MY_VAR "value"
fish_add_path -gpm /path/to/bin
```

### 添加配置文件

1. 将配置文件放入 `symlinks/` 目录
2. 保持相对于 `$HOME` 的路径结构

例如，添加 `~/.config/myapp/config.yml`：

```bash
mkdir -p symlinks/.config/myapp
# 将 config.yml 放入 symlinks/.config/myapp/
```

### 添加新的语言/工具

1. 在 `pkg/basic/` 创建目录（基础工具）或 `pkg/additional/`（可选工具）
2. 编写 `install.sh`
3. 使用 `mise::setup` + `mise use -g`（mise 管理的工具）
4. 或使用 `zerobrew::install`（普通 CLI 工具）
5. 如需安装 Homebrew cask 或 tap formula，使用 `homebrew::cask::install` / `homebrew::tap::install`
6. 如需配置环境变量，编辑 `system/path.fish`

## 安装模式

| 模式 | 命令 | 说明 |
|------|------|------|
| 完整安装 | `bash ./script/bootstrap` | 安装 basic + additional |
| 最小安装 | `DOT_MODE=mini bash ./script/bootstrap` | 只安装 basic |
| 强制重置 | `FORCE_MACOS_DEFAULTS=1 bash ./script/bootstrap` | 重新应用 macOS 默认设置 |
