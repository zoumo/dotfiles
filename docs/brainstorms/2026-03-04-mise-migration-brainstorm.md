# Mise Migration Brainstorm

**Date:** 2026-03-04
**Status:** Ready for planning

## What We're Building

Migrate the dotfiles repository from a fragmented version management approach (gvm, nodenv, jenv, Homebrew) to **mise** for Go, Node.js, Java, and Rust - while preserving the existing `uv` setup for Python.

The migration will:
1. Add idempotent mise installation following existing patterns
2. Keep existing tool directories (go/, java/, rust/, nodejs/) but use mise for installation
3. Use `mise settings` commands for configuration (not direct file writes)
4. Replace shell hooks in `system/path.fish`

## Why This Approach

**Current State:**
| Language | Version Manager | Pinned Version |
|----------|-----------------|----------------|
| Python | uv | 3.12 |
| Go | gvm | 1.24.2 |
| Node.js | nodenv | 23.2.0 |
| Java | jenv | None |
| Rust | Homebrew | None |

**Motivations:**
- **Unification**: One tool, one config, simpler maintenance
- **Per-project versions**: Auto-switching via mise's `.mise.toml`
- **Performance**: Faster installs, caching, parallel downloads

**Why keep uv for Python:**
- Recently migrated from pyenv to uv
- uv provides excellent package management alongside version management
- No need to disrupt working Python setup

## Key Decisions

### 1. Script Structure
- **New**: `pkg/basic/mise/install.sh` - idempotent mise installation
- **Modified**: `pkg/basic/go/install.sh` - use mise to install Go instead of gvm
- **Modified**: `pkg/basic/java/install.sh` - use mise to install Java instead of jenv
- **Modified**: `pkg/basic/rust/install.sh` - use mise to install Rust
- **Modified**: `pkg/additional/nodejs/install.sh` - use mise to install Node.js instead of nodenv

### 2. Configuration Approach
- Use `mise settings` commands instead of writing config files directly
- Global configuration at `~/.config/mise/config.toml` (managed by mise commands)
- No direct file writes - all configuration through mise CLI

### 3. Shell Integration
- Replace gvm/nodenv/jenv hooks in `system/path.fish` with `mise activate fish`
- Clean replacement, no commented-out legacy code

### 4. Version Pinning
- Go: `1.24.2` (current pinned version)
- Node.js: `23.2.0` (current pinned version)
- Java: `21` (LTS, reasonable default)
- Rust: `latest` (or specific stable version)
- Python: Keep uv, no mise integration

### 5. Configuration Scope
- Start with global config only
- Add per-project `.mise.toml` files later as needed

## Open Questions

None - requirements are clear.

## Implementation Notes

### Mise Installation Script Pattern

Following existing idempotent patterns in the codebase:

```bash
#!/usr/bin/env bash

# Check if mise is already installed
if command::exists mise; then
  log::info "mise is already installed"
  exit 0
fi

# Install mise (macOS via Homebrew or curl)
if OS::LSBDist "macos"; then
  brew install mise
else
  curl https://mise.run | sh
fi

# Initialize mise for fish shell
mise activate fish > ~/.config/fish/conf.d/mise.fish
```

### Tool Installation Pattern

In each tool's install.sh:

```bash
#!/usr/bin/env bash

# Example: go/install.sh
VERSION="go1.24.2"

# Install via mise
mise install $VERSION
mise use -g $VERSION
```

## Next Steps

Run `/workflows:plan` to create detailed implementation plan.