# export DOTFILES=$HOME/.dotfiles
source $HOME/.dotfiles/system/os.sh
export -f command_exists >/dev/null 2>&1

export GOPATH="$HOME/.golang"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${GOPATH}/bin/:${HOME}/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
