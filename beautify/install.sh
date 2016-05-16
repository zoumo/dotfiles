# !/bin/sh

plugins=${HOME}/plugins

if [[ ! -d ${plugins} ]]; then
    mkdir ${plugins}
fi

cd ${plugins}

# install powerline fonts
if [[ ! -d ${plugins}/fonts ]]; then
	git clone https://github.com/powerline/fonts
	sh ./fonts/install.sh
fi

# install solarized and dircolors
if [[ ! -d ${plugins}/solarized ]]; then
	git clone https://github.com/altercation/solarized.git

    if [[ $OS == "osx" ]]; then
        open "${plugins}/solarized/iterm2-colors-solarized/Solarized Dark.itermcolors"
        open "${plugins}/solarized/osx-terminal.app-colors-solarized/xterm-256color/Solarized Dark xterm-256color.terminal"
    elif [[ $OS == "centos" ]]; then
        if [[ ! -d ${plugins}/gnome-terminal-colors-solarized ]]; then
            git clone https://github.com/Anthony25/gnome-terminal-colors-solarized.git
        fi
        if [[ -z $(which dconf) ]]; then
            sudo yum install dconf
        fi
        # need dconf
        sh ./gnome-terminal-colors-solarized/install.sh
    fi
fi

if [[ ! -d ${plugins}/dircolors-solarized ]]; then
	git clone https://github.com/seebi/dircolors-solarized.git
fi


exit 0