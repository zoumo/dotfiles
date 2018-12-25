#!/bin/bash
import util/log
# enable basic logging for this file by declaring a namespace
namespace lib/git
# make the Log method direct everything in the namespace 'myApp' to the log handler called DEBUG
Log::AddOutput lib/git STATUS

git::failed_checkout() {
	subject=ERROR Log "Failed to git clone $1"
	exit -1
}

git::clone() {
	[ -d "$2" ] || git clone --depth 1 "$1" "$2" || failed_checkout "$1"
}
