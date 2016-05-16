if [[ "$(uname -s)" == "Darwin" ]]; then
    export OS="osx"
elif [[ "$(uname -s)" == "Linux" -a -n $(which yum) ]]; then
    export OS="centos"
fi
export GOPATH="$HOME/.golang"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${GOPATH}/bin/:${HOME}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
