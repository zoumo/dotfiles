function proxy_on() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:1087/"
    export https_proxy=${http_proxy}
    export HTTP_PROXY=${http_proxy}
    export HTTPS_PROXY=${http_proxy}
    echo "=> terminal proxy on"
    echo "forward to 127.0.0.1:1087."
    echo "please check your privoxy listening on 1087"
}

function proxy_off() {
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    echo "=> terminal proxy off"
}
