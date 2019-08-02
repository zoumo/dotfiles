#!/bin/bash

source "$(dirname ${BASH_SOURCE})"/../../framework/oo-bootstrap.sh

namespace centos
Log::AddOutput centos NOTE

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
    curl
    file
    perl
    yodl
)

# EPEL(http://fedoraproject.org/wiki/EPEL) 是由 Fedora 社区打造，
# 为 RHEL 及衍生发行版如 CentOS、Scientific Linux 等提供高质量软件包的项目。
# 官方的源更新滞后, 有些拓展源没有
sudo yum -y update
sudo yum remove -y epel-release
sudo yum install -y epel-release

# https://centos.pkgs.org/7/forensics-x86_64/cert-forensics-tools-release-7.noarch.rpm.html
# rpm -ivh https://forensics.cert.org/cert-forensics-tools-release-el7.rpm
# sudo yum --enablerepo=forensics install cert-forensics-tools-release

# # remi 源
# rpm -ivh https://mirrors.tuna.tsinghua.edu.cn/remi/enterprise/remi-release-7.rpm
# # 修改第一个 enabled=0 为 enabled=1
# sed -i ':a;N;$!ba;s/enabled=0/enabled=1/' /etc/yum.repos.d/remi.repo

sudo yum groupinstall -y 'Development Tools'

sudo yum install -y ${binaries[@]}

brew::setup
