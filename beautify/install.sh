#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source ${ROOT_PATH}/lib/init.sh

cd ${plugins}

# install one dark for iterm
if [[ ! -d ${plugins}/one-dark-iterm ]]; then
	git clone https://github.com/anunez/one-dark-iterm.git

	if [[ ${OS} == "macos" ]]; then
		open "${plugins}/one-dark-iterm/one-dark.itermcolors"
	fi
fi

# install solarized for terminal
if [[ ! -d ${plugins}/solarized ]]; then
	git clone https://github.com/altercation/solarized.git

	if [[ ${OS} == "macos" ]]; then
		open "${plugins}/solarized/osx-terminal.app-colors-solarized/xterm-256color/Solarized Dark xterm-256color.terminal"
	elif [[ ${OS} == "centos" ]] && util::command_exists gnome-shell; then
		if [[ ! -d ${plugins}/gnome-terminal-colors-solarized ]]; then
			git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
		fi
		# need dconf
		sh ./gnome-terminal-colors-solarized/install.sh
	fi
fi

# install dircolors-solarized
if [[ ! -d ${plugins}/dircolors-solarized ]]; then
	git clone https://github.com/seebi/dircolors-solarized.git
	cp ${plugins}/dircolors-solarized/dircolors.ansi-dark $HOME/.dircolors
fi

exit 0
