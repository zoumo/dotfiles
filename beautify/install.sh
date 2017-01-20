#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

plugins=${HOME}/.dotfiles/plugins

if [[ ! -d ${plugins} ]]; then
	mkdir -p ${plugins}
fi

cd ${plugins}

install_fonts() {
	# install powerline fonts
	if [[ ! -d ${plugins}/fonts ]]; then
		git clone https://github.com/powerline/fonts
		sh ./fonts/install.sh
	fi
}

# install powerline
if command_exists pip; then
	pip_install powerline-status
fi

# install one dark for iterm
if [[ ! -d ${plugins}/one-dark-iterm ]]; then
	git clone https://github.com/anunez/one-dark-iterm.git
    
	if [[ $OS == "osx" ]]; then
		install_fonts
		open "${plugins}/one-dark-iterm/one-dark.itermcolors"

	fi
fi

# install solarized for terminal
if [[ ! -d ${plugins}/solarized ]]; then
	git clone https://github.com/altercation/solarized.git

	if [[ $OS == "osx" ]]; then
		install_fonts
		open "${plugins}/solarized/iterm2-colors-solarized/Solarized Dark.itermcolors"
		open "${plugins}/solarized/osx-terminal.app-colors-solarized/xterm-256color/Solarized Dark xterm-256color.terminal"
	elif [[ $OS == "centos" ]] && command_exists gnome-shell; then
		install_fonts
		if [[ ! -d ${plugins}/gnome-terminal-colors-solarized ]]; then
			git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
		fi
		if ! command_exists dconf; then
			sudo yum install dconf
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
