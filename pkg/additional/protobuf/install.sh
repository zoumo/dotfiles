#!/bin/bash
source "$(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh"

namespace protobuf
Log::AddOutput protobuf NOTE

zerobrew::install protobuf
