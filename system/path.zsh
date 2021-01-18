export EDITOR='vim'

# cleanup path
export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# brew is a custom function at here
eval $(brew shellenv)

if [[ $(os_lsb_dist) == "macos" ]]; then
    export OPT_PATH="/usr/local/opt"
    export PATH="${OPT_PATH}/coreutils/libexec/gnubin/:${OPT_PATH}/gnu-sed/libexec/gnubin/:${OPT_PATH}/make/libexec/gnubin:${PATH}"
    export MANPATH="${OPT_PATH}/coreutils/libexec/gnuman:${MANPATH}"
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# ====================================================================
# use clang
# ====================================================================
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# ====================================================================
# Golang
# ====================================================================
if command_exists go; then
    export GOPATH="${HOME}/golang"
    export GOROOT="$(brew --prefix go)/libexec"
    export GO15VENDOREXPERIMENT=1
    export GO111MODULE=auto
    export PATH="${GOPATH}/bin:${GOPATH}/bin/kubebuilder:${PATH}"
fi

# ====================================================================
# Rust
# ====================================================================
if [[ -d "${HOME}/.cargo/bin" ]]; then
    export PATH="${HOME}/.cargo/bin:${PATH}"
fi

# ====================================================================
# python
# ====================================================================
# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

if command_exists pyenv; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

if [[ $(os_lsb_dist) == "macos" ]]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang"
else
    export PYTHON_CONFIGURE_OPTS="--enable-shared CC=clang"
fi

export PYTHONDONTWRITEBYTECODE=x

# virtualenv config
export VIRTUALENV_USE_DISTRIBUTE=1
export VIRTUALENV_NO_SITE_PACKAGES=1 # 设置所有虚拟环境与系统site-packages进行隔离

# ====================================================================
# ruby
# ====================================================================
if command_exists rbenv; then
    eval "$(rbenv init -)"
fi

# ====================================================================
# nodenv
# ====================================================================
if command_exists nodenv; then
    eval "$(nodenv init -)"
fi

if command_exists yvm; then
    export YVM_DIR=${HOME}/.yvm
    source /usr/local/bin/yvm
fi

# ====================================================================
# zsh-autosuggestions
# ====================================================================
# set highlight foreground colour to
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"

# ====================================================================
# kube-ps1
# ====================================================================

# source "${OPT_PATH}/kube-ps1/share/kube-ps1.sh"
# PS1='$(kube_ps1)'$PS1
