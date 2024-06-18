#!/bin/bash

source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

# A smarter cd command.
brew::install zoxide

# fzf
brew::install fzf

# starship
brew::install starship
