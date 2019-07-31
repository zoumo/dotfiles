#!/bin/bash
import util/log
# enable basic logging for this file by declaring a namespace
namespace lib/util
# make the Log method direct everything in the namespace 'myApp' to the log handler called DEBUG
Log::AddOutput lib/util STATUS

util::find_installer() {
    declare -a result
    index=1
    for dir in $(ls); do
        if [[ -d $dir && -e $dir/install.sh ]]; then
            result[$index]=$dir
            index=$(($index + 1))
        fi
    done
    echo ${result[@]}
}

os::macos() {
    [[ $(OS::LSBDist) == "macos" ]]
}

util::pip_install() {
    for item in "$@"; do
        if [[ ! $(pip show $item) ]]; then
            Log "pip installing $item"
            pip install $item
        else
            Log "util::pip_install: $item already exists, skip it"
        fi
    done
}

util::pip_install_one() {
    if [[ ! $(pip show $item) ]]; then
        Log "pip installing $1"
        pip install "$@"
    else
        Log "util::pip_install: $1 already exists, skip it"
    fi
}

util::link_file() {
    local src=$1 dst=$2

    local overwrite= backup= skip=
    local action=

    if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

        if [[ "$overwrite_all" == "false" ]] && [[ "$backup_all" == "false" ]] && [[ "$skip_all" == "false" ]]; then
            local currentSrc="$(readlink $dst)"

            if [[ "$currentSrc" == "$src" ]]; then
                skip=true
            else
                Log "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
                    [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
                read -n 1 action

                case "$action" in
                o)
                    overwrite=true
                    ;;
                O)
                    overwrite_all=true
                    ;;
                b)
                    backup=true
                    ;;
                B)
                    backup_all=true
                    ;;
                s)
                    skip=true
                    ;;
                S)
                    skip_all=true
                    ;;
                *) ;;
                esac
            fi

        fi

        overwrite=${overwrite:-$overwrite_all}
        backup=${backup:-$backup_all}
        skip=${skip:-$skip_all}

        if [[ "$overwrite" == "true" ]]; then
            rm -rf "$dst"
            Log "removed $dst"
        fi

        if [[ "$backup" == "true" ]]; then
            mv "$dst" "${dst}.backup"
            Log "moved $dst to ${dst}.backup"
        fi

        if [[ "$skip" == "true" ]]; then
            Log "skipped $src"
        fi
    fi

    if [[ "$skip" != "true" ]]; then # "false" or empty
        ln -s "$1" "$2"
        Log "linked $1 to $2"
    fi
    echo
}
