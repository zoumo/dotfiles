# !/bin/sh

plugins=${HOME}/plugins

if [[ ! -d ${plugins} ]]; then
    mkdir ${plugins}
fi

cd ${plugins}

# install powerline fonts
git clone https://github.com/powerline/fonts
sh ./fonts/install.sh

# install solarized adn dircolors
git clone https://github.com/altercation/solarized.git
git clone https://github.com/seebi/dircolors-solarized.git

open "${plugins}/solarized/iterm2-colors-solarized/Solarized Dark.itermcolors"
open "${plugins}/solarized/osx-terminal.app-colors-solarized/xterm-256color/Solarized Dark ansi.terminal"


exit 0