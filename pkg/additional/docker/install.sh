#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace docker
Log::AddOutput docker NOTE

if [[ ${DOT_MODE:-} == "mini" ]]; then
    Log "skipping docker installation in mini mode"
    exit 0
fi

if Command::Exists docker; then
    Log "docker has already existed, skip it"
    exit 0
fi

if os::macos; then
    brew::cask::install docker
else
    curl -fsSL https://get.docker.com | sudo bash

    # Manage Docker as a non-root user
    [[ -n $(cat /etc/group | cut -f 1 -d : | grep docker) ]] || sudo groupadd docker
    sudo usermod -aG docker $USER

    sudo systemctl start docker
    # Configure Docker to start on boot
    sudo systemctl enable docker
fi

# if [[ $(OS::LSBDist) == "centos" ]]; then
#     sudo yum install -y yum-utils device-mapper-persistent-data lvm2
#     sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#     sudo yum install -y docker-ce

#     # Manage Docker as a non-root user
#     [[ -n $(cat /etc/group | cut -f 1 -d : | grep docker) ]] || sudo groupadd docker
#     sudo usermod -aG docker $USER

#     sudo systemctl start docker
#     # Configure Docker to start on boot
#     sudo systemctl enable docker
# elif [[ $(OS::LSBDist) == "debian" ]]; then
#     # SET UP THE REPOSITORY
#     sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
#     curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
#     sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
#     # INSTALL DOCKER ENGINE - COMMUNITY
#     sudo apt-get install -y docker-ce

#     # Manage Docker as a non-root user
#     [[ -n $(cat /etc/group | cut -f 1 -d : | grep docker) ]] || sudo groupadd docker
#     sudo usermod -aG docker $USER

#     sudo systemctl start docker
#     # Configure Docker to start on boot
#     sudo systemctl enable docke
# fi
