#!/bin/sh

function command_exists() {
    command -v "$@" > /dev/null 2>&1
}

if command_exists gem; then
    gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
fi
