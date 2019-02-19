#!/bin/bash
import util/log
# enable basic logging for this file by declaring a namespace
namespace lib/semver
# make the Log method direct everything in the namespace 'myApp' to the log handler called DEBUG
Log::AddOutput lib/semver ERROR

SEMVER_REGEX="^(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)(\\.(0|[1-9][0-9]*))?(\\-[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?(\\+[0-9A-Za-z-]+(\\.[0-9A-Za-z-]+)*)?$"

semver::validate_version() {
    local version=$1
    if [[ "$version" =~ $SEMVER_REGEX ]]; then
        # if a second argument is passed, store the result in var named by $2
        if [ "$#" -eq "2" ]; then
            local major=${BASH_REMATCH[1]}
            local minor=${BASH_REMATCH[2]}
            local patch=${BASH_REMATCH[4]}
            local prere=${BASH_REMATCH[5]}
            local build=${BASH_REMATCH[7]}

            [[ -n $patch ]] || patch=0
            eval "$2=(\"$major\" \"$minor\" \"$patch\" \"$prere\" \"$build\")"
        else
            echo "$version"
        fi
    else
        Log "version $version does not match the semver scheme 'X.Y(.Z)(-PRERELEASE)(+BUILD)'."
    fi
}

semver::compare() {
    semver::validate_version "$1" V
    semver::validate_version "$2" V_

    # MAJOR, MINOR and PATCH should compare numericaly
    for i in 0 1 2; do
        local diff=$((${V[$i]} - ${V_[$i]}))
        if [[ $diff -lt 0 ]]; then
            echo -1
            return 0
        elif [[ $diff -gt 0 ]]; then
            echo 1
            return 0
        fi
    done

    # PREREL should compare with the ASCII order.
    if [[ -z "${V[3]}" ]] && [[ -n "${V_[3]}" ]]; then
        echo 1
        return 0
    elif [[ -n "${V[3]}" ]] && [[ -z "${V_[3]}" ]]; then
        echo -1
        return 0
    elif [[ -n "${V[3]}" ]] && [[ -n "${V_[3]}" ]]; then
        if [[ "${V[3]}" > "${V_[3]}" ]]; then
            echo 1
            return 0
        elif [[ "${V[3]}" < "${V_[3]}" ]]; then
            echo -1
            return 0
        fi
    fi

    echo 0
}
