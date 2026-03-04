---
title: "Migrate from fragmented version managers to mise for unified tool management"
date: 2026-03-04
type: feat
severity: medium
category: tooling
component: dotfiles/version-management
tags:
  - mise
  - version-manager
  - go
  - nodejs
  - java
  - rust
  - migration
  - unification
  - developer-experience
related_issues:
  - "#1 (Python uv migration - precedent for modern tool adoption)"
---

# Migrate from fragmented version managers to mise for unified tool management

## Problem Statement

The dotfiles repository used **four different version managers** with inconsistent patterns:

| Language | Previous Manager | Issues |
|----------|-----------------|--------|
| **Go** | gvm | Complex setup, slow compilation from source |
| **Node.js** | nodenv | Required node-build plugin, manual version installation |
| **Java** | jenv | No version pinned by default, complex export plugin hooks |
| **Rust** | Homebrew | No version control at all - just installed whatever version was available |

**Key Problems:**
- **Maintenance Overhead**: Each tool had different commands, configs, and update patterns
- **Inconsistent UX**: Different activation hooks, different ways to set global/local versions
- **Slow Installation**: gvm and nodenv compiled from source (10-30 minutes for Python/Go)
- **No Per-Project Switching**: Difficult to automatically switch versions based on project directory
- **Complex Shell Config**: Multiple `init` hooks in `path.fish` cluttering the shell startup

## Root Cause

The version management approach evolved organically over time, with each language added using its own "standard" version manager. This resulted in:

1. **gvm** (Go Version Manager) - Required bash scripts, manual sourcing, compilation
2. **nodenv** (Node.js) - Required node-build plugin installation separately
3. **jenv** (Java) - Required export plugin for JAVA_HOME, complex hook system
4. **Homebrew** (Rust) - No version pinning, just direct install

Each tool had its own:
- Installation method (curl | bash, git clone, brew install)
- Configuration location (~/.gvm, ~/.nodenv, ~/.jenv)
- Shell hook pattern (eval "$(gvm ...)", nodenv init, jenv init)
- Version specification format (.gvmrc, .node-version, jenv versions)

## Solution

### 1. Create `framework/lib/mise.sh` - Minimal Utility Library

```bash
#!/bin/bash
import util/log
import util/command

namespace lib/mise
Log::AddOutput lib/mise STATUS

# Install mise via Homebrew (idempotent)
# Note: 'mise use -g <tool>@<version>' auto-installs the tool
mise::setup() {
    if Command::Exists mise; then
        return 0
    fi

    Log "Installing mise via Homebrew..."
    brew::install mise

    # Verify installation
    if ! Command::Exists mise; then
        Log "mise: installation failed"
        return 1
    fi

    # Generate fish completions (non-fatal)
    mkdir -p ~/.config/fish/completions 2>/dev/null
    mise completions fish > ~/.config/fish/completions/mise.fish 2>/dev/null || true

    Log "mise $(mise --version 2>/dev/null | head -1) installed"
}
```

**Key Design Decisions:**
- Idempotent: Returns early if mise already installed
- Uses `brew::install` which is itself idempotent
- Non-fatal completion generation (uses `|| true`)
- Leverages existing `Command::Exists` and `Log` utilities from bash-oo-framework

### 2. Add Global Import in `framework/lib/global.sh`

```bash
import lib/mise    # NEW: Global mise utilities
```

This ensures `mise::setup` is available in all install scripts without per-script imports.

### 3. Update Install Scripts

**Pattern for all tools:**

```bash
#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace <tool>
Log::AddOutput <tool> NOTE

VERSION="<explicit-version>"  # Always pin version

# Ensure mise is available (idempotent)
mise::setup

# Install and set as global (mise use -g auto-installs)
mise use -g "<tool>@${VERSION}"

Log "<Tool> $(<tool> --version 2>/dev/null) installed"
```

**Go (`pkg/basic/go/install.sh`):**
```bash
VERSION="1.24.2"
mise::setup
mise use -g "go@${VERSION}"
```

**Node.js (`pkg/additional/nodejs/install.sh`):**
```bash
VERSION="23.2.0"
mise::setup
mise use -g "node@${VERSION}"
```

**Java (`pkg/basic/java/install.sh`):**
```bash
VERSION="21"
mise::setup
mise use -g "java@${VERSION}"
mise settings set java.java_home true 2>/dev/null || true
```

**Rust (`pkg/basic/rust/install.sh`):**
```bash
mise::setup
mise use -g "rust"  # Latest stable
```

### 4. Update `system/path.fish`

**Remove (legacy hooks):**
```fish
set -gx GVM_ROOT "$HOME/.gvm"

if command_exists nodenv
    nodenv init - fish | source
end

if command_exists jenv
    fish_add_path -gpm $HOME/.jenv/bin
    jenv init - fish | source
end
```

**Add (unified mise activation):**
```fish
# ====================================================================
# mise - version manager for Go, Node.js, Java, Rust
# ====================================================================
if command_exists mise
    mise activate fish | source
end

# Go
set -gx GO111MODULE auto
```

### 5. Remove Legacy Files

```bash
rm -rf symlinks/.jenv/
```

## Results

| Metric | Before | After |
|--------|--------|-------|
| **Version Managers** | 4 (gvm, nodenv, jenv, brew) | 1 (mise) |
| **Shell Init Hooks** | 3 separate hooks | 1 unified hook |
| **Install Script Lines** | ~50+ per language | ~10 per language |
| **Installation Time** | 10-30 min (compile) | Seconds (pre-built binaries) |
| **Per-Project Switching** | Manual/expensive | Automatic via `.mise.toml` |

## Verification

```bash
# Open new terminal or reload fish
exec fish

# Verify mise is active
which mise           # Should show path
mise doctor          # Run diagnostics

# List all managed tools
mise ls              # Should show go, node, java, rust

# Verify each tool
go version           # go1.24.2
node --version       # v23.2.0
java -version        # 21.x.x
rustc --version      # 1.x.x

# Check environment variables
echo $JAVA_HOME      # Should be set by mise
```

## Prevention Strategies

### Before Migration

1. **Backup current versions:**
   ```bash
   go version > ~/pre-migration-backup.txt
   node --version >> ~/pre-migration-backup.txt
   java -version 2>&1 >> ~/pre-migration-backup.txt
   ```

2. **Check for conflicts:**
   ```bash
   find ~ -name ".gvmrc" -o -name ".node-version" 2>/dev/null
   ```

### Best Practices

1. **Pin explicit versions:**
   ```bash
   # Good
   mise use -g go@1.24.2

   # Avoid (can break builds)
   mise use -g go@latest
   ```

2. **Use `mise settings` CLI, not direct file writes:**
   ```bash
   # Correct
   mise settings set java.java_home true

   # Avoid
   echo 'java.java_home = true' >> ~/.config/mise/config.toml
   ```

3. **Per-project version management:**
   Create `.mise.toml` in project roots:
   ```toml
   [tools]
   go = "1.22"
   node = "20"
   ```

## Rollback

If needed, rollback is possible:

```bash
# 1. Export mise config
mise ls > ~/mise-config-backup.txt

# 2. Remove mise
mise uninstall --all
brew uninstall mise

# 3. Restore legacy managers from git history
git checkout HEAD~1 -- pkg/basic/go/install.sh
git checkout HEAD~1 -- pkg/basic/java/install.sh
# etc.
```

## Related

- **Precedent:** Python migration from pyenv to uv (PR #1)
- **Documentation:** [mise.jdx.dev](https://mise.jdx.dev/)
- **Use command:** [mise use](https://mise.jdx.dev/cli/use.html) - auto-installs if missing
- **Language backends:** [mise langs](https://mise.jdx.dev/langs.html)

## Files Changed

- `framework/lib/mise.sh` (new)
- `framework/lib/global.sh` (modified)
- `pkg/basic/go/install.sh` (modified)
- `pkg/basic/java/install.sh` (modified)
- `pkg/basic/rust/install.sh` (modified)
- `pkg/additional/nodejs/install.sh` (modified)
- `system/path.fish` (modified)
- `symlinks/.jenv/` (deleted)