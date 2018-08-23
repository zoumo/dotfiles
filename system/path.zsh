function command_exists() {
	command -v "$@" >/dev/null 2>&1
}

declare -g lsb_dist

lsb_dist() {
	if [[ -n ${lsb_dist} ]]; then
		echo ${lsb_dist}
		return
	fi
	# perform some very rudimentary platform detection
	if Command::Exists lsb_release; then
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

	lsb_dist="$(echo "${lsb_dist}" | cut -d " " -f1 | tr '[:upper:]' '[:lower:]')"

	# Special case redhatenterpriseserver
	if [ "${lsb_dist}" = "redhatenterpriseserver" ]; then
		# Set it to redhat, it will be changed to centos below anyways
		lsb_dist='redhat'
	fi

	if [ ${lsb_dist} == 'redhat' ]; then
		lsb_dist='centos'
	fi

	lsb_dist=${lsb_dist}
	echo ${lsb_dist}
}

export -f command_exists >/dev/null 2>&1

export EDITOR='vim'
export GOPATH="${HOME}/.golang"
export GO15VENDOREXPERIMENT=1
export PATH="${GOPATH}/bin/:${HOME}/bin:${HOME}/bin/kubebuilder:${PATH}"
if [[ ${lsb_dist} == "macos" ]]; then
	export GOROOT="/usr/local/opt/go/libexec"
	export PATH="/usr/local/opt/curl/bin:/usr/local/opt/coreutils/libexec/gnubin/:/usr/local/opt/node/bin/:/usr/local/opt/make/libexec/gnubin:${PATH}"
	export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
	export JAVA_HOME=$(/usr/libexec/java_home)
fi

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
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYTHONDONTWRITEBYTECODE=x

# ====================================================================
# zplug
# ====================================================================
export ZPLUG_HOME=${HOME}/.zplug

# ====================================================================
# ruby
# ====================================================================

if [[ ${os} == "centos" ]]; then
	export PATH="${HOME}/.rbenv/bin:${PATH}"
fi

eval "$(rbenv init -)"

# ====================================================================
# nodenv
# ====================================================================

if [[ ${lsb_dist} != "macos" ]]; then
	PATH="$HOME/.nodenv/bin:$PATH"
fi
eval "$(nodenv init -)"
