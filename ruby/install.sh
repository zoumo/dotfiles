#!/bin/sh

if command_exists gem; then
    gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/
fi
