#!/bin/bash

binaries=(
    dconf
    gcc-6
    clang
    bzip2
    openssl-devel
    libyaml-devel
    libffi-devel
    readline-devel
    zlib-devel
    gdbm-devel
    libevent-devel
    ncurses-devel
    deltarpm
    python-devel
    the_silver_searcher
    cmake
)

yum groupinstall -y 'Development Tools'

yum install -y ${binaries[@]}
