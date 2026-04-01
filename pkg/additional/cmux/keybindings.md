# cmux Keybindings (tmux-style)

## Why the Leader Key Differs from tmux

tmux uses a **prefix key** mechanism: press `Ctrl+A` (or `Ctrl+B`), release, then press
the action key. This two-step sequence works because tmux intercepts raw terminal input
and maintains its own modal state — it knows to "wait" for the next keystroke after
seeing the prefix.

cmux is a native macOS app built on AppKit. macOS keyboard handling only supports
**simultaneous modifier+key** combinations (like `Cmd+D`), not prefix-then-key sequences.
There is no built-in way for a macOS app to enter a "waiting for next key" mode after
a prefix press. Implementing a custom prefix engine would conflict with the system
input method, accessibility, and menu bar shortcut resolution.

So instead of the tmux two-step `ctrl+a, <key>`, we use `cmd+ctrl+<key>` as a
single chord. The action keys (h/j/k/l, -, enter, etc.) stay the same to preserve
muscle memory — only the "how you hold the modifier" part changes.

## Shortcut Mapping

| tmux bind | Action | cmux default | Script changes to | Status |
| --- | --- | --- | --- | --- |
| `ctrl+a -` | Split Down | `cmd+shift+d` | — | Keep default |
| `ctrl+a \|` | Split Right | `cmd+d` | — | Keep default |
| `ctrl+a h/j/k/l` | Focus Pane | `cmd+opt+arrow` | `cmd+ctrl+h/j/k/l` | Modified |
| `ctrl+a shift+h/j/k/l` | Resize Pane | Drag divider / Equalize | — | No shortcut |
| `ctrl+a >` / `ctrl+a <` | Swap Pane | — | — | Not supported |
| `ctrl+a z` | Pane Zoom | `cmd+shift+enter` | `cmd+ctrl+z` | Modified |
| `ctrl+a enter` | Copy Mode | `cmd+shift+m` | `cmd+ctrl+enter` | Modified |
| `ctrl+a ctrl+h/l` | Prev/Next Workspace | `cmd+1/2/3...` | `cmd+ctrl+shift+h/l` | Modified |
| `ctrl+a ctrl+shift+h/l` | Swap Workspace Order | Drag in sidebar | — | No shortcut |
| `ctrl+a tab` | Last Workspace | — | — | Not supported |
| `ctrl+a ctrl+c` | New Session | `cmd+shift+n` | — | Keep default |
| `ctrl+a ctrl+f` | Find Session | Command Palette | — | Keep default |
| `ctrl+a shift+tab` | Last Session | — | — | Not supported |
| `ctrl+a b` | List Buffers | — | — | Not supported |
| `ctrl+a p/shift+p` | Paste Buffer | `cmd+v` (system) | — | Keep default |

## Configuration

Run `setup-keybindings.sh` to apply. Restart cmux after running.

```bash
./setup-keybindings.sh           # configure Release app
./setup-keybindings.sh --debug   # configure Debug app
./setup-keybindings.sh --reset   # remove all custom shortcuts
```

To reset a single shortcut:

```bash
defaults delete com.cmuxterm.app shortcut.focusLeft
```
