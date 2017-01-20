#!/bin/bash

set -e

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

if command_exists gem; then
    gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
fi
