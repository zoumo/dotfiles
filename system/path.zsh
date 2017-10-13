function command_exists() {
    command -v "$@" > /dev/null 2>&1
}

# set default
: ${os:=""}

# perform some very rudimentary platform detection
if command_exists lsb_release; then
    os="$(lsb_release -si)"
fi
if [ -z "$os" ] && [ -r /etc/lsb-release ]; then
    os="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
fi
if [ -z "$os" ] && [ -r /etc/debian_version ]; then
    os='debian'
fi
if [ -z "$os" ] && [ -r /etc/fedora-release ]; then
    os='fedora'
fi
if [ -z "$os" ] && [ -r /etc/oracle-release ]; then
    os='oracleserver'
fi
if [ -z "$os" ] && [ -r /etc/centos-release ]; then
    os='centos'
fi
if [ -z "$os" ] && [ -r /etc/redhat-release ]; then
    os='redhat'
fi
if [ -z "$os" ] && [ -r /etc/photon-release ]; then
    os='photon'
fi
if [ -z "$os" ] && [ -r /etc/os-release ]; then
    os="$(. /etc/os-release && echo "$ID")"
fi
if [ -z "$os" ] && [[ "$(uname -s)" == "Darwin" ]]; then
    os="macos"
fi

os="$(echo "$os" | cut -d " " -f1 | tr '[:upper:]' '[:lower:]')"

# Special case redhatenterpriseserver
if [ "${os}" = "redhatenterpriseserver" ]; then
        # Set it to redhat, it will be changed to centos below anyways
        lsb_dist='redhat'
fi


export -f command_exists >/dev/null 2>&1

export OS=$os
export EDITOR='vim'
export GOPATH="$HOME/.golang"
export GO15VENDOREXPERIMENT=1
export PATH="${GOPATH}/bin/:${HOME}/bin:$PATH"
if [[ $OS == "macos" ]]; then
    export GOROOT="/usr/local/opt/go/libexec"
    export PATH="/usr/local/opt/curl/bin:$PATH:/usr/local/opt/coreutils/libexec/gnubin/:/usr/local/opt/node/bin/"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# ====================================================================
# python
# ====================================================================
# virtualenv config
export VIRTUALENV_USE_DISTRIBUTE=1
export VIRTUALENV_NO_SITE_PACKAGES=1  # 设置所有虚拟环境与系统site-packages进行隔离

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYTHONDONTWRITEBYTECODE=x

# thefuck
eval $(thefuck --alias)

# ====================================================================
# zplug
# ====================================================================
export ZPLUG_HOME=/usr/local/opt/zplug

# ====================================================================
# rvm
# ====================================================================
if [[ $OS == "macos" ]]; then
    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
elif [[ $OS == "centos" ]]; then
    source /etc/profile.d/rvm.sh
fi
