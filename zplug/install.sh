#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

## fasd
brew::install fasd

## fzf
brew::install fzf
