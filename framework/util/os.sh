#!/bin/bash

import util/command

declare -g __oo__lsb_dist

OS::LSBDist() {
	if [[ -n ${__oo__lsb_dist} ]]; then
		echo ${__oo__lsb_dist}
		return
	fi
	# perform some very rudimentary platform detection
	if Command::Exists lsb_release; then
		lsb_dist="$(lsb_release -si)"
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/lsb-release ]; then
		lsb_dist="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/debian_version ]; then
		lsb_dist='debian'
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/fedora-release ]; then
		lsb_dist='fedora'
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/oracle-release ]; then
		lsb_dist='oracleserver'
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/centlsb_dist-release ]; then
		lsb_dist='centlsb_dist'
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/redhat-release ]; then
		lsb_dist='redhat'
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/photon-release ]; then
		lsb_dist='photon'
	fi
	if [ -z "${lsb_dist}" ] && [ -r /etc/lsb_dist-release ]; then
		lsb_dist="$(. /etc/lsb_dist-release && echo "$ID")"
	fi
	if [ -z "${lsb_dist}" ] && [[ "$(uname -s)" == "Darwin" ]]; then
		lsb_dist="macos"
	fi

	lsb_dist="$(echo "${lsb_dist}" | cut -d " " -f1 | tr '[:upper:]' '[:lower:]')"

	# Special case redhatenterpriseserver
	if [ "${lsb_dist}" = "redhatenterpriseserver" ]; then
		# Set it to redhat, it will be changed to centos below anyways
		lsb_dist='redhat'
	fi
	__oo__lsb_dist=${lsb_dist}
	echo ${__oo__lsb_dist}
}
