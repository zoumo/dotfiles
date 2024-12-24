#!/usr/bin/env fish

function proxy_toggle
    if test -n "$http_proxy"
        set -e http_proxy
        set -e https_proxy
        set -e HTTP_PROXY
        set -e HTTPS_PROXY
        set -e ALL_PROXY
        echo "==> terminal proxy off"
    else
        set proxy_addr $PROXY_ADDR; or set proxy_addr 127.0.0.1:7890
        set -gx no_proxy "localhost,127.0.0.1,localaddress,.localdomain.com"
        set -gx http_proxy "http://$proxy_addr/"
        set -gx https_proxy $http_proxy
        set -gx HTTP_PROXY $http_proxy
        set -gx HTTPS_PROXY $http_proxy
        set -gx ALL_PROXY $http_proxy
        echo "==> terminal proxy on"
        echo "forward to $proxy_addr."
        echo "please check your proxy is listening on the right port"
    end
end
