#!/usr/bin/env fish

function os_lsb_dist
    set -l lsb_dist ''
    # perform some very rudimentary platform detection
    if command -v lsb_release >/dev/null 2>&1
        set lsb_dist (lsb_release -si | string collect; or echo)
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/lsb-release ]
        set lsb_dist (babelfish < /etc/lsb-release | source && echo "$DISTRIB_ID" | string collect; or echo)
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/debian_version ]
        set lsb_dist debian
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/fedora-release ]
        set lsb_dist fedora
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/oracle-release ]
        set lsb_dist oracleserver
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/centlsb_dist-release ]
        set lsb_dist centlsb_dist
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/redhat-release ]
        set lsb_dist redhat
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/photon-release ]
        set lsb_dist photon
    end
    if [ -z "$lsb_dist" ] && [ -r /etc/lsb_dist-release ]
        set lsb_dist (babelfish < /etc/lsb_dist-release | source && echo "$ID" | string collect; or echo)
    end
    if [ -z "$lsb_dist" ] && test (uname -s | string collect; or echo) = Darwin
        set lsb_dist macos
    end
    set lsb_dist (echo $lsb_dist | cut -d ' ' -f1 | tr '[:upper:]' '[:lower:]' | string collect; or echo)
    # Special case redhatenterpriseserver
    if test "$lsb_dist" = redhatenterpriseserver
        # Set it to redhat, it will be changed to centos below anyways
        set lsb_dist redhat
    end
    if test "$lsb_dist" = redhat
        set lsb_dist centos
    end
    echo "$lsb_dist"
end
