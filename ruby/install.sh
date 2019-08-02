#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

VERSION="2.6.3"

rbenv_from_src() {
    git::clone https://github.com/rbenv/rbenv.git $HOME/.rbenv
    [[ ! -x $HOME/.rbenv/bin/rbenv ]] || cd $HOME/.rbenv && src/configure && make -C src
    export PATH="$HOME/.rbenv/bin:$PATH"
    # install ruby-build
    mkdir -p "$(rbenv root)"/plugins
    git::clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
}

if os::macos; then
    brew::install libyaml libffi openssl openssl@1.1
else
    brew::install libffi openssl openssl@1.1
fi

if ! Command::Exists rbenv; then
    brew::install rbenv

    # temporary export
    export PATH="$(brew --prefix rbenv)/bin:$PATH"

    mkdir -p "$(rbenv root)"/plugins
    # make cache
    mkdir -p "$(rbenv root)"/cache

    git::clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
    git::clone https://github.com/andorchen/rbenv-china-mirror.git "$(rbenv root)"/plugins/rbenv-china-mirror
    eval "$(rbenv init -)"
fi

if [[ ! $(rbenv versions | grep $VERSION) ]]; then
    RUBY_CONFIGURE_OPTS="--disable-install-doc --with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline)" CC=clang rbenv install $VERSION -v
fi

rbenv global $VERSION
