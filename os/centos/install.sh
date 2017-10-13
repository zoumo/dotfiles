#!/bin/bash

binaries=(
    dconf
    gcc-6
    bzip2
    openssl-devel
    libyaml-devel
    libffi-devel
    readline-devel
    zlib-devel
    gdbm-devel
    ncurses-devel
)

yum install -y ${binaries[@]}
