#!/bin/bash
source $(dirname ${BASH_SOURCE})/../../../framework/oo-bootstrap.sh

namespace protobuf
Log::AddOutput protobuf NOTE

if [[ ${DOT_MODE:-} == "mini" ]]; then
    Log "skipping protobuf installation in mini mode"
    exit 0
fi

brew::install protobuf

if Command::Exists go; then
    # install protobuf
    export GO111MODULE=on
    # install golang protobuf lib
    go get -v github.com/golang/protobuf/proto
    # install golang protobuf generate plugin
    go get -v github.com/golang/protobuf/protoc-gen-go

    # gogo plugin
    go get -v github.com/gogo/protobuf/protoc-gen-gogo
    # gofast plugin
    go get -v github.com/gogo/protobuf/protoc-gen-gofast

    # gogo lib
    go get -v github.com/gogo/protobuf/proto
    go get -v github.com/gogo/protobuf/gogoproto

    go get -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
    go get -v github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
fi
