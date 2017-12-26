#!/bin/bash

container="golang"
go17_tag="1.7"
go18_tag="1.8"

go17_image="${container}:${go17_tag}"
go17_dir="${GOPATH}/containers/${go17_tag}" 
go18_image="${container}:${go18_tag}"
go18_dir="${GOPATH}/containers/${go17_tag}" 


function image-exists
{
    if [[ -z $(docker images $image -q) ]]; then 
        echo "1" > /dev/null 2>&1
    fi
}


function go-pkg
{
    path=$(pwd)
    path=${path##*$GOPATH/src/}
    echo $path
}

function go17
{
    if [[ ! -d $go17_dir ]]; then
        mkdir -p $go17_dir
    fi    

    if ! image-exists $go17_image; then
        docker pull $go17_image
    fi

    pkg=$(go-pkg)

    docker run --rm -v $go17_dir:/go -v $(pwd):/go/src/$(go-pkg) -w /go/src/$pkg $go17_image $@
    
}


function go18
{
    
    if [[ ! -d $go18_dir ]]; then
        mkdir -p $go18_dir
    fi    

    if ! image-exists $go18_image; then
        docker pull $go18_image
    fi

    pkg=$(go-pkg)

    docker run --rm -v $go18_dir:/go -v $(pwd):/go/src/$(go-pkg) -w /go/src/$pkg $go18_image $@
    
}
