command_exists() {
    command -v "$@" >/dev/null 2>&1
}

declare -g __lsb_dist

os_lsb_dist() {

    if [[ -n ${__lsb_dist} ]]; then
        echo ${__lsb_dist}
        return
    fi

    local lsb_dist=""
    # perform some very rudimentary platform detection
    if command_exists lsb_release; then
        lsb_dist="$(lsb_release -si)"
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/lsb-release ]; then
        lsb_dist="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/debian_version ]; then
        lsb_dist='debian'
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/fedora-release ]; then
        lsb_dist='fedora'
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/oracle-release ]; then
        lsb_dist='oracleserver'
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/centlsb_dist-release ]; then
        lsb_dist='centlsb_dist'
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/redhat-release ]; then
        lsb_dist='redhat'
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/photon-release ]; then
        lsb_dist='photon'
    fi
    if [ -z "${lsb_dist}" ] && [ -r /etc/lsb_dist-release ]; then
        lsb_dist="$(. /etc/lsb_dist-release && echo "$ID")"
    fi
    if [ -z "${lsb_dist}" ] && [[ "$(uname -s)" == "Darwin" ]]; then
        lsb_dist="macos"
    fi

    lsb_dist="$(echo ${lsb_dist} | cut -d ' ' -f1 | tr '[:upper:]' '[:lower:]')"

    # Special case redhatenterpriseserver
    if [[ "${lsb_dist}" == "redhatenterpriseserver" ]]; then
        # Set it to redhat, it will be changed to centos below anyways
        lsb_dist="redhat"
    fi

    if [[ ${lsb_dist} == "redhat" ]]; then
        lsb_dist='centos'
    fi
    __lsb_dist=${lsb_dist}
    echo ${__lsb_dist}
}

brewable() {
    [[ "$(os_lsb_dist)" == "macos" ]] || [[ "$(whoami)" != "root" ]]
}

export -f command_exists >/dev/null 2>&1
export -f os_lsb_dist >/dev/null 2>&1

export EDITOR='vim'

# cleanup path
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

if [[ brewable ]] && [[ "$(os_lsb_dist)" != "macos" ]]; then
    # add linuxbrew to path
    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
fi

export PATH="${GOPATH}/bin/:${HOME}/bin:${HOME}/bin/kubebuilder:${PATH}"

if [[ $(os_lsb_dist) == "macos" ]]; then
    export PATH="/usr/local/opt/curl/bin:/usr/local/opt/coreutils/libexec/gnubin/:/usr/local/opt/node/bin/:/usr/local/opt/make/libexec/gnubin:${PATH}"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# ====================================================================
# Golang
# ====================================================================
export GOPATH="${HOME}/.golang"
export GO15VENDOREXPERIMENT=1
export GO111MODULE=on
if [[ $(os_lsb_dist) == "macos" ]]; then
    export GOROOT="/usr/local/opt/go/libexec"
fi

# ====================================================================
# Rust
# ====================================================================
export PATH="${HOME}/.cargo/bin:${PATH}"

# ====================================================================
# use clang
# ====================================================================
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# ====================================================================
# python
# ====================================================================
# virtualenv config
export VIRTUALENV_USE_DISTRIBUTE=1
export VIRTUALENV_NO_SITE_PACKAGES=1 # 设置所有虚拟环境与系统site-packages进行隔离

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"

if [[ $(os_lsb_dist) == "macos" ]]; then
    export PYTHON_CONFIGURE_OPTS="--enable-framework CC=clang"
else
    export PYTHON_CONFIGURE_OPTS="--enable-shared CC=clang"
fi

if command_exists pyenv; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
export PYTHONDONTWRITEBYTECODE=x

# ====================================================================
# zplug
# ====================================================================
export ZPLUG_HOME=${HOME}/.zplug

# ====================================================================
# ruby
# ====================================================================

if [[ $(os_lsb_dist) != "macos" ]]; then
    export PATH="${HOME}/.rbenv/bin:${PATH}"
fi

if command_exists rbenv; then
    eval "$(rbenv init -)"
fi

# ====================================================================
# nodenv
# ====================================================================

if ! brewable; then
    PATH="$HOME/.nodenv/bin:$PATH"
fi
if command_exists nodenv; then
    eval "$(nodenv init -)"
fi

if command_exists yvm; then
    export YVM_DIR=${HOME}/.yvm
    source /usr/local/bin/yvm
fi

# ====================================================================
# kube-ps1
# ====================================================================

# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
# PS1='$(kube_ps1)'$PS1
