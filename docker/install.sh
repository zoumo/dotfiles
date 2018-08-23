#!/bin/bash
source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

if [[ $(OS::LSBDist) == "centos" ]]; then
	sudo yum install -y yum-utils device-mapper-persistent-data lvm2
	sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum makecache fast
	sudo yum install -y docker-ce
	sudo systemctl start docker

	# Manage Docker as a non-root user
	sudo groupadd docker
	sudo usermod -aG docker $USER

	# Configure Docker to start on boot
	sudo systemctl enable docker
fi
