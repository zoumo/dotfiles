#!/bin/bash

# detect host os 

# set default
: ${os:=""}

# perform some very rudimentary platform detection
if util::command_exists lsb_release; then
	os="$(lsb_release -si)"
fi
if [ -z "${OS}" ] && [ -r /etc/lsb-release ]; then
	os="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
fi
if [ -z "${OS}" ] && [ -r /etc/debian_version ]; then
	os='debian'
fi
if [ -z "${OS}" ] && [ -r /etc/fedora-release ]; then
	os='fedora'
fi
if [ -z "${OS}" ] && [ -r /etc/oracle-release ]; then
	os='oracleserver'
fi
if [ -z "${OS}" ] && [ -r /etc/centos-release ]; then
	os='centos'
fi
if [ -z "${OS}" ] && [ -r /etc/redhat-release ]; then
	os='redhat'
fi
if [ -z "${OS}" ] && [ -r /etc/photon-release ]; then
	os='photon'
fi
if [ -z "${OS}" ] && [ -r /etc/os-release ]; then
	os="$(. /etc/os-release && echo "$ID")"
fi
if [ -z "${OS}" ] && [[ "$(uname -s)" == "Darwin" ]]; then
	os="macos"
fi

os="$(echo "${OS}" | cut -d " " -f1 | tr '[:upper:]' '[:lower:]')"

# Special case redhatenterpriseserver
if [ "${os}" = "redhatenterpriseserver" ]; then
	# Set it to redhat, it will be changed to centos below anyways
	lsb_dist='redhat'
fi

OS=${OS}
