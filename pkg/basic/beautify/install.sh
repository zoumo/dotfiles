#!/bin/bash

PKG_PATH="$(cd "$(dirname ${BASH_SOURCE})" && pwd -P)"
source ${PKG_PATH}/../../../framework/oo-bootstrap.sh

cd ${DOT_PLUGINS}

# download one dark
git::clone https://github.com/nathanbuchar/atom-one-dark-terminal.git atom-one-dark-terminal
# download solarized
git::clone https://github.com/altercation/solarized.git solarized

if os::macos; then
    # install one dark for iterm2
    # open "atom-one-dark-terminal/scheme/iterm/One Dark.itermcolors"
    # install one dark for terminal
    open "atom-one-dark-terminal/scheme/terminal/One Dark.terminal"
elif Command::Exists gnome-shell; then
    git::clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git gnome-terminal-colors-solarized
    # need dconf
    sh ./gnome-terminal-colors-solarized/install.sh
fi

# install dircolors-solarized for GNU ls
git::clone https://github.com/seebi/dircolors-solarized.git dircolors-solarized
cp dircolors-solarized/dircolors.ansi-dark $HOME/.dircolors

exit 0
