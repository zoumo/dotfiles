#!/usr/bin/env bash
#
# cmux tmux-style keybindings setup
#
# Leader: Cmd+Ctrl (replaces tmux Ctrl+A prefix)
#
# Usage:
#   ./setup-keybindings.sh           # configure Release app
#   ./setup-keybindings.sh --debug   # configure Debug app
#   ./setup-keybindings.sh --reset   # remove all custom shortcuts (Release)
#
# Restart cmux after running.

set -euo pipefail

DOMAIN="com.cmuxterm.app"

for arg in "$@"; do
  case "$arg" in
    --debug) DOMAIN="com.cmuxterm.app.debug" ;;
    --reset)
      echo "Resetting all custom shortcuts..."
      for key in \
        shortcut.focusLeft shortcut.focusRight shortcut.focusUp shortcut.focusDown \
        \
        shortcut.toggleTerminalCopyMode shortcut.toggleSplitZoom \
        shortcut.prevSidebarTab shortcut.nextSidebarTab; do
        defaults delete "$DOMAIN" "$key" 2>/dev/null || true
      done
      echo "Done. Restart cmux to apply defaults."
      exit 0
      ;;
  esac
done

write_shortcut() {
  local defaults_key="$1"
  local key="$2"
  local cmd="$3"
  local shift="$4"
  local opt="$5"
  local ctrl="$6"

  local json="{\"key\":\"${key}\",\"command\":${cmd},\"shift\":${shift},\"option\":${opt},\"control\":${ctrl}}"
  local hex
  hex="$(printf '%s' "$json" | xxd -p | tr -d '\n')"
  defaults write "$DOMAIN" "$defaults_key" -data "$hex"

  # Pretty print for confirmation
  local mods=""
  [[ "$ctrl" == "true" ]] && mods+="Ctrl+"
  [[ "$opt"  == "true" ]] && mods+="Opt+"
  [[ "$shift" == "true" ]] && mods+="Shift+"
  [[ "$cmd"  == "true" ]] && mods+="Cmd+"
  local display_key="$key"
  [[ "$key" == $'\r' ]] && display_key="Enter"
  printf "  %-40s → %s%s\n" "$defaults_key" "$mods" "$display_key"
}

echo "Configuring cmux keybindings (domain: $DOMAIN)"
echo ""

# ── Focus pane: Cmd+Ctrl + h/j/k/l ──
echo "Pane focus (Cmd+Ctrl + h/j/k/l):"
write_shortcut "shortcut.focusLeft"  "h" true false false true
write_shortcut "shortcut.focusRight" "l" true false false true
write_shortcut "shortcut.focusUp"    "k" true false false true
write_shortcut "shortcut.focusDown"  "j" true false false true
echo ""

# ── Copy mode: Cmd+Ctrl + Enter (tmux: prefix + Enter) ──
echo "Copy mode (Cmd+Ctrl + Enter):"
write_shortcut "shortcut.toggleTerminalCopyMode" $'\r' true false false true
echo ""

# ── Pane zoom: Cmd+Ctrl + z (tmux: prefix + z) ──
echo "Pane zoom (Cmd+Ctrl + z):"
write_shortcut "shortcut.toggleSplitZoom" "z" true false false true
echo ""

# ── Workspace navigation: Cmd+Ctrl+Shift + h/l (tmux: prefix + C-h/C-l) ──
echo "Workspace navigation (Cmd+Ctrl+Shift + h/l):"
write_shortcut "shortcut.prevSidebarTab" "h" true true false true
write_shortcut "shortcut.nextSidebarTab" "l" true true false true
echo ""

echo "Done. Restart cmux to apply."
