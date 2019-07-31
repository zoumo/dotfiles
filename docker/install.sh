#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

namespace docker
Log::AddOutput docker NOTE

if Command::Exists docker; then
    Log "docker has already existed, skip it"
    docker version
    exit 0
fi

if os::macos; then
    brew::cask::install docker
elif [[ $(OS::LSBDist) == "centos" ]]; then
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce
    sudo systemctl start docker

    # Manage Docker as a non-root user
    [[ -n $(cat /etc/group | cut -f 1 -d : | grep docker) ]] || sudo groupadd docker
    sudo usermod -aG docker $USER

    # Configure Docker to start on boot
    sudo systemctl enable docker
fi
