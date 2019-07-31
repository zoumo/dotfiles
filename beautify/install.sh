#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

cd ${DOT_PLUGINS}

# install one dark for iterm
git::clone https://github.com/nathanbuchar/atom-one-dark-terminal.git atom-one-dark-terminal

if [[ $(OS::LSBDist) == "macos" ]]; then
    open "atom-one-dark-terminal/scheme/iterm/One Dark.itermcolors"
    open "atom-one-dark-terminal/scheme/terminal/One Dark.terminal"
fi

# install solarized for terminal
git::clone https://github.com/altercation/solarized.git solarized

if [[ $(OS::LSBDist) == "centos" ]] && Command::Exists gnome-shell; then
    git::clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git gnome-terminal-colors-solarized
    # need dconf
    sh ./gnome-terminal-colors-solarized/install.sh
fi

# install dircolors-solarized
git::clone https://github.com/seebi/dircolors-solarized.git dircolors-solarized
cp dircolors-solarized/dircolors.ansi-dark $HOME/.dircolors

exit 0
