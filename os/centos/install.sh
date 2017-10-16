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
    ncurses-devel
    deltarpm
)

yum install -y ${binaries[@]}
