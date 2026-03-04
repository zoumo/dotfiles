---
title: feat: Migrate to mise for version management
type: feat
date: 2026-03-04
---

# feat: Migrate to mise for version management

## Overview

Migrate the dotfiles repository from fragmented version management (gvm, nodenv, jenv, Homebrew) to **mise** for Go, Node.js, Java, and Rust - while preserving the existing `uv` setup for Python.

## Problem Statement

The current setup uses multiple version managers with inconsistent patterns:

| Language | Current Manager | Issue |
|----------|-----------------|-------|
| Go | gvm | Complex setup, slow |
| Node.js | nodenv | Requires node-build plugin |
| Java | jenv | No version pinned, complex hooks |
| Rust | Homebrew | No version control at all |

This creates maintenance overhead, inconsistent UX, and makes per-project version switching difficult.

## Proposed Solution

Replace all version managers with mise, which provides:
- **Unified interface**: One tool for all languages
- **Declarative config**: `~/.config/mise/config.toml`
- **Per-project switching**: Automatic via `.mise.toml`
- **Performance**: Parallel downloads, caching
- **Auto-install**: `mise use -g go@1.24.2` installs if missing

## Technical Approach

### Files to Create

#### 1. `framework/lib/mise.sh`

Minimal utility library - just ensures mise is installed:

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

### Files to Modify

#### 2. `framework/lib/global.sh`

Add `import lib/mise` to load globally:

```bash
#!/bin/bash
import util/os
import util/command
import lib/brew
import lib/util
import lib/git
import lib/semver
import lib/system
import util/log
import lib/mise    # NEW: Global mise utilities

DOT_ROOT="$(cd "${__oo__path}" && pwd -P)"
DOT_PLUGINS=${DOT_ROOT}/plugins
DOT_CACHE=${HOME}/.cache/dotfiles

if [[ ! -d ${DOT_PLUGINS} ]]; then
    mkdir -p "${DOT_PLUGINS}"
fi

if [[ ! -d ${DOT_CACHE} ]]; then
    mkdir -p "${DOT_CACHE}"
fi
```

#### 3. `pkg/basic/go/install.sh`

Replace gvm-based installation with mise:

```bash
#!/usr/bin/env bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace go
Log::AddOutput go NOTE

VERSION="1.24.2"

# Ensure mise is available (lib/mise is auto-loaded via global.sh)
mise::setup

# Install and set as global (mise use -g auto-installs)
mise use -g "go@${VERSION}"

Log "Go $(go version 2>/dev/null | awk '{print $3}') installed"
```

#### 4. `pkg/basic/java/install.sh`

Replace jenv-based installation with mise:

```bash
#!/usr/bin/env bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace java
Log::AddOutput java NOTE

VERSION="21"

# Ensure mise is available
mise::setup

# Install and set as global (mise use -g auto-installs)
mise use -g "java@${VERSION}"

# Enable JAVA_HOME setting
mise settings set java.java_home true 2>/dev/null || true

Log "Java $(java -version 2>&1 | head -1) installed"
```

#### 5. `pkg/basic/rust/install.sh`

Replace Homebrew with mise:

```bash
#!/usr/bin/env bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace rust
Log::AddOutput rust NOTE

# Ensure mise is available
mise::setup

# Install Rust (latest stable) and set as global
mise use -g "rust"

Log "Rust $(rustc --version 2>/dev/null) installed"
```

#### 6. `pkg/additional/nodejs/install.sh`

Replace nodenv with mise:

```bash
#!/usr/bin/env bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace nodejs
Log::AddOutput nodejs NOTE

VERSION="23.2.0"

# Ensure mise is available
mise::setup

# Install and set as global (mise use -g auto-installs)
mise use -g "node@${VERSION}"

Log "Node.js $(node --version 2>/dev/null) installed"
```

#### 7. `system/path.fish`

Replace gvm/nodenv/jenv hooks with mise:

**Remove these sections:**
```fish
# Golang (lines ~33-36)
set -gx GVM_ROOT "$HOME/.gvm"
set -gx GO111MODULE auto

# nodenv (lines ~48-51)
if command_exists nodenv
    nodenv init - fish | source
end

# java (lines ~54-58)
fish_add_path -gpm $HOME/.jenv/bin
if command_exists jenv
    jenv init - fish | source
end
```

**Add this section:**
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

### Files to Remove

#### 8. `symlinks/.jenv/` directory

Remove the entire directory:
```
symlinks/.jenv/
└── plugins/
    └── export/
        └── etc/
            └── jenv.d/
                └── init/
                    └── export_jenv_hook.fish
```

## Acceptance Criteria

- [x] `framework/lib/mise.sh` exists with `mise::setup()` function
- [x] `framework/lib/global.sh` includes `import lib/mise`
- [x] `pkg/basic/go/install.sh` uses `mise use -g` instead of gvm
- [x] `pkg/basic/java/install.sh` uses `mise use -g` instead of jenv
- [x] `pkg/basic/rust/install.sh` uses `mise use -g` instead of Homebrew
- [x] `pkg/additional/nodejs/install.sh` uses `mise use -g` instead of nodenv
- [x] `system/path.fish` has mise activation, no legacy tool hooks
- [x] `symlinks/.jenv/` directory removed
- [ ] `mise::setup()` is idempotent (re-running produces no changes)
- [ ] `mise ls` shows correct versions after running scripts
- [ ] `go version` returns 1.24.2
- [ ] `node --version` returns v23.2.0
- [ ] `java -version` returns 21
- [ ] `rustc --version` returns latest stable

## Success Metrics

- **Single tool**: All 4 languages managed by mise
- **Clean shell config**: One `mise activate` instead of 3 tool hooks
- **Minimal code**: ~25 lines in lib/mise.sh, ~10 lines per install script
- **Global import**: `lib/mise` loaded via `global.sh`, no per-script imports

## Dependencies & Risks

### Dependencies
- mise requires Homebrew on macOS (already a dependency)
- mise config directory: `~/.config/mise/`

### Risks

| Risk | Mitigation |
|------|------------|
| Network failure during install | User can re-run install scripts |
| JAVA_HOME not set | `mise settings set java.java_home true` |
| User has existing mise config | `mise use -g` adds to config, preserves existing |

## Post-Installation Cleanup (Documented)

After running the scripts, users can optionally clean up legacy tools:

```bash
# Remove gvm (optional)
rm -rf ~/.gvm

# Remove nodenv (optional)
brew uninstall nodenv node-build 2>/dev/null || true
rm -rf ~/.nodenv

# Remove jenv (optional)
brew uninstall jenv 2>/dev/null || true
rm -rf ~/.jenv
```

## References & Research

### Internal References
- Utility library pattern: `framework/lib/brew.sh`
- Global imports: `framework/lib/global.sh`
- Command existence: `framework/util/command.sh:Command::Exists()`
- Logging pattern: `pkg/basic/python/install.sh` (recent uv migration)
- Shell hooks: `system/path.fish`

### External References
- [mise documentation](https://mise.jdx.dev/)
- [mise use command](https://mise.jdx.dev/cli/use.html) - auto-installs if missing
- [mise language backends](https://mise.jdx.dev/langs.html)