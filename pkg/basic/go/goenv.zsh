#!/bin/bash

# Copyright 2022 jim.zoumo@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if command_exists go; then
    export BREW_GO_VERSION="${HOME}/.brew_go_version"
    export GOPATH="${HOME}/golang"
    export GO15VENDOREXPERIMENT=1
    export GO111MODULE=on
    export PATH="${GOPATH}/bin:${GOPATH}/bin/kubebuilder:${PATH}"

    # find correct goroot
    local go_version="go"
    if [[ -f ${BREW_GO_VERSION} ]]; then
        go_version_in_file=$(cat ${BREW_GO_VERSION})
        if [[ -n ${go_version_in_file} ]]; then
            go_version=${go_version_in_file}
        fi
    fi
    export GOROOT="$(brew --prefix ${go_version})/libexec"
fi
