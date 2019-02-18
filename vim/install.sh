#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

cd ${plugins}

MINIMUM_VIM_VERSION="8.0"

# 安装依赖
if [[ $(OS::LSBDist) == "macos" ]]; then
    util::brew_install ctags the_silver_searcher
    # mac中的vim版本太低, 换成macvim
    pyenv local system
    # use python3
    util::brew_install python
    util::brew_install_one macvim --with-override-system-vim
    pyenv local --unset

elif [[ $(OS::LSBDist) == 'centos' ]]; then
    if Command::Exists vim; then
        vim_version="$(vim --version | head -1 | cut -f 5 -d " ")"
        if [[ "${MINIMUM_VIM_VERSION}" != $(echo -e "${MINIMUM_VIM_VERSION}\n${vim_version}" | sort -s -t. -k 1,1n -k 2,2n | head -n1) ]]; then

            # ruby  - ryenv
            # python3 - pyenv
            sudo yum install -y lua lua-devel luajit \
                luajit-devel ctags git tcl-devel \
                perl perl-devel perl-ExtUtils-ParseXS \
                perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
                perl-ExtUtils-Embed
            # This step is needed to rectify an issue with how Fedora 20 installs XSubPP:
            # symlink xsubpp (perl) from /usr/bin to the perl dir
            sudo ln -s /usr/bin/xsubpp /usr/share/perl5/ExtUtils/xsubpp

            git::clone https://github.com/vim/vim.git
            cd vim

            make distclean # if you build Vim before
            ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-python3interp=yes \
                --with-python3-config-dir=$(python3-config --configdir) \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --enable-gui=gtk2 \
                --enable-cscope \
                --prefix=/usr/local
            sudo make install
            cp src/vim /usr/local/bin/vim
        fi
    fi
fi

# 可以选择安装
# brew tap neovim/neovim
# brew install --HEAD neovim
# pip install neovim

# use spacevim
curl -sLf https://spacevim.org/install.sh | bash

mkdir -p ${HOME}/.SpaceVim.d/autoload
ln -sf ${DOT_ROOT}/vim/init.toml ${HOME}/.SpaceVim.d/init.toml
ln -sf ${DOT_ROOT}/vim/zoumo.vim ${HOME}/.SpaceVim.d/autoload/zoumo.vim
