#!/bin/bash

ROOT_PATH="$(dirname $(dirname ${BASH_SOURCE}))"
source $ROOT_PATH/lib/lib.sh

if ! command_exists zplug; then
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi
