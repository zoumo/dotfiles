function proxy_on() {
    proxy_addr=${PROXY_ADDR:-127.0.0.1:1087}
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://${proxy_addr}/"
    export https_proxy=${http_proxy}
    export HTTP_PROXY=${http_proxy}
    export HTTPS_PROXY=${http_proxy}
    echo "=> terminal proxy on"
    echo "forward to ${proxy_addr}."
    echo "please check your privoxy listening on the right port"
}

function proxy_off() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    echo "=> terminal proxy off"
}
