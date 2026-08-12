# Zellij 安装与配置

Zellij 是本仓库默认的交互式终端工作区和会话管理器。考虑到其他组件可能
依赖 tmux，原有 tmux、smug、Oh My Tmux 安装与配置保持不变；完整安装会
同时安装两套工具。`mux` 默认执行 `zellij attach --create zoumo`。

## 安装流程

完整安装时，`script/dot` 会自动发现
`pkg/additional/zellij/install.sh`，并通过 Zerobrew 幂等安装 Zellij：

```bash
bash ./script/bootstrap
```

如果只需要安装 Zellij，可以在仓库根目录执行：

```bash
bash ./pkg/additional/zellij/install.sh
```

## 配置链接

配置源文件位于：

- `symlinks/.config/zellij/config.kdl`
- `symlinks/.config/zellij/layouts/default.kdl`

`script/linkfile` 会将它们链接到：

- `~/.config/zellij/config.kdl`
- `~/.config/zellij/layouts/default.kdl`

单独刷新软链接：

```bash
bash ./script/linkfile
```

## 终端启动

Alacritty 和 Ghostty 的配置也由仓库管理。两个终端都先启动登录 Fish，再
通过 Fish 的初始化命令进入 Zellij：

- `symlinks/.config/alacritty/alacritty.toml`
- `symlinks/.config/ghostty/config`

它们分别链接到 `~/.config/alacritty/alacritty.toml` 和
`~/.config/ghostty/config`。等价启动命令为：

```bash
/opt/zerobrew/bin/fish -l --init-command 'zellij attach --create zoumo'
```

打开新的终端窗口或标签页时，两个终端都会连接到同一个 `zoumo` session；
session 不存在时自动创建。退出或 detach Zellij 后会回到外层 Fish。原有
tmux 与 smug 安装不受影响；`mux` 也会连接或创建同一个 Zellij session。

## 默认行为

- 主题：`gruvbox-dark`
- 默认 layout：`default`
- 默认 layout 为等分四宫格，初始焦点位于左上 pane
- pane 边框开启，保留顶部 Tab 栏与底部状态栏
- pane 继承启动 Zellij 时的工作目录
- Session 默认支持 detach、后台运行和退出后的布局恢复

进入或创建一个名为 `zoumo` 的 Zellij session：

```bash
zellij attach --create zoumo
```

## tmux 风格快捷键

配置同时支持 `Ctrl-b` 和 `Ctrl-a` 作为前缀。主要映射如下：

| 快捷键 | 操作 |
|--------|------|
| `<prefix> -` | 向下分屏 |
| `<prefix> \|` | 向右分屏 |
| `<prefix> h/j/k/l` | 切换 pane |
| `<prefix> H/J/K/L` | 调整 pane 大小 |
| `<prefix> c` | 新建 Tab |
| `<prefix> Ctrl-h/Ctrl-l` | 前一个/后一个 Tab |
| `<prefix> 1..9` | 跳转到指定 Tab |
| `<prefix> z` 或 `<prefix> +` | pane 全屏切换 |
| `<prefix> [` 或 `<prefix> Enter` | 进入滚动/复制模式 |
| `<prefix> d` | Detach，session 留在后台 |
| `<prefix> Ctrl-f` | 打开 Session Manager |

## Session 常用命令

```bash
zellij --session work          # 创建并进入命名 session
zellij ls                      # 查看 session
zellij attach work             # 重新连接
zellij attach --create work    # 不存在则创建
zellij attach -b work          # 创建后台 session
```

## Layout

新 session 默认加载 `default.kdl`。在现有 session 中执行下面的命令，会
以默认四宫格创建一个新 Tab：

```bash
zellij --layout default
```

## 验证

修改配置后运行：

```bash
zellij setup --check
```

配置通常会热加载；需要重启的选项会在 `config.kdl` 注释中注明。
