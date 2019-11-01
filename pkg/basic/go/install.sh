#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace golang
Log::AddOutput golang NOTE

if Command::Exists go; then
    Log "golang has already existed, skip it"
    go version
    exit 0
fi

brew::install go mercurial

exit 0
