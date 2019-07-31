#!/bin/bash

source $(dirname $(dirname ${BASH_SOURCE}))/framework/oo-bootstrap.sh

## fasd
brew::install fasd

## fzf
brew::install fzf
# To install useful keybindings and fuzzy completion
$(brew --prefix fzf)/install --all --no-update-rc
