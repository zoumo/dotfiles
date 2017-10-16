#!/bin/bash

binaries=(
    yum-axelget
    git
    dconf
    gcc
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
    zsh
)

# EPEL(http://fedoraproject.org/wiki/EPEL) 是由 Fedora 社区打造，
# 为 RHEL 及衍生发行版如 CentOS、Scientific Linux 等提供高质量软件包的项目。
# 官方的源更新滞后, 有些拓展源没有
sudo yum -y update
sudo yum remove -y epel-release
sudo yum install -y epel-release

sudo yum groupinstall -y 'Development Tools'

sudo yum install -y ${binaries[@]}
