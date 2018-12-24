#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

ZPLUG_HOME=$HOME/.zplug
git::clone https://github.com/zplug/zplug $ZPLUG_HOME
