#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

VERSION="2.6.3"

if ! Command::Exists rbenv; then
    if [[ $(OS::LSBDist) == "macos" ]]; then
        util::brew_install rbenv
    else
        git::clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
        [[ ! -x $HOME/.rbenv/bin/rbenv ]] || cd $HOME/.rbenv && src/configure && make -C src
        export PATH="$HOME/.rbenv/bin:$PATH"
        # install ruby-build
        mkdir -p "$(rbenv root)"/plugins
        git::clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    fi
    eval "$(rbenv init -)"
fi

if [[ ! $(rbenv versions | grep $VERSION) ]]; then
    RUBY_CONFIGURE_OPTS=--disable-install-doc rbenv install $VERSION -v
fi

rbenv global $VERSION
