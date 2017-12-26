#!/bin/bash

# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in pipeline.
set -o pipefail

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source ${ROOT_PATH}/lib/init.sh

if [[ ${OS} == "centos" ]]; then
	sudo yum install -y yum-utils
	sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
	sudo yum makecache fast
	sudo yum install -y docker-ce
	sudo systemctl start docker

	# 
	sudo groupadd docker
	sudo usermod -aG docker $USER

	#
	sudo systemctl enable docker
fi
