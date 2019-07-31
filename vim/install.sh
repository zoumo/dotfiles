#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

namespace vim
Log::AddOutput vim ERROR

cd ${DOT_PLUGINS}

MINIMUM_VIM_VERSION="8.0"

# 安装依赖
if os::macos; then
    brew::install ctags the_silver_searcher
    # replace vim with macvim
    pyenv local system
    # use python3
    brew::install python macvim
    pyenv local --unset
else
    brew::install vim
fi

# if [[ $(OS::LSBDist) == 'centos' ]]; then
#     VIM_VERSION=""
#     if Command::Exists vim; then
#         VIM_VERSION="$(vim --version | head -1 | cut -f 5 -d " ")"
#     fi
#     if [[ ${VIM_VERSION} == "" ]] || (($(semver::compare ${VIM_VERSION} ${MINIMUM_VIM_VERSION}) == -1)); then
#         # ruby  - rbenv
#         if ! Command::Exists rbenv; then
#             Log "ruby is required in compiling vim, please install rbenv firstly"
#             exit 1
#         fi
#         if ! Command::Exists pyenv; then
#             Log "python is required in compiling vim, please install pyenv firstly"
#             exit 1
#         fi
#         # python3 - pyenv
#         sudo yum install -y lua lua-devel luajit \
#             luajit-devel ctags git tcl-devel \
#             perl perl-devel perl-ExtUtils-ParseXS \
#             perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
#             perl-ExtUtils-Embed
#         # This step is needed to rectify an issue with how Fedora 20 installs XSubPP:
#         # symlink xsubpp (perl) from /usr/bin to the perl dir
#         sudo ln -sf /usr/bin/xsubpp /usr/share/perl5/ExtUtils/xsubpp
#         git::clone https://github.com/vim/vim.git vim
#         cd vim
#         make distclean # if you build Vim before
#         ./configure --with-features=huge \
#             --enable-multibyte \
#             --enable-rubyinterp=yes \
#             --enable-python3interp=yes \
#             --with-python3-config-dir=$(python3-config --configdir) \
#             --enable-perlinterp=yes \
#             --enable-luainterp=yes \
#             --enable-gui=gtk2 \
#             --enable-cscope \
#             --prefix=/usr/local
#         sudo make install
#         cp src/vim /usr/local/bin/vim
#     fi
# fi

# use spacevim
curl -sLf https://spacevim.org/install.sh | bash

mkdir -p ${HOME}/.SpaceVim.d/autoload
ln -sf ${DOT_ROOT}/vim/init.toml ${HOME}/.SpaceVim.d/init.toml
ln -sf ${DOT_ROOT}/vim/customize.vim ${HOME}/.SpaceVim.d/autoload/customize.vim
