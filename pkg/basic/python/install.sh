#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace python
Log::AddOutput python NOTE

brew::shellenv

# Install uv - modern Python package manager
# brew::install handles idempotency (skips if already installed)
brew::install uv

# Install auto-uv-env for automatic venv activation
# brew tap is idempotent (safe to run if already tapped)
brew tap ashwch/tap
brew::install auto-uv-env

# 下载加速
export UV_PYTHON_INSTALL_MIRROR="https://gh-proxy.com/https://github.com/astral-sh/python-build-standalone/releases/download"
# Configure uv mirror (idempotent - overwrites existing)
mkdir -p ~/.config/uv
cat > ~/.config/uv/uv.toml << 'EOF'
[[index]]
url = "http://mirrors.aliyun.com/pypi/simple"
default = true
EOF

# Install Python 3.12.x (latest patch version)
# uv python install is idempotent (skips if already installed)
uv python install 3.12

Log "Python $(uv python find 3.12) installed successfully"
Log "Virtual environments will auto-activate via auto-uv-env"
