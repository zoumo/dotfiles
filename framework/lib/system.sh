#!/bin/bash

system::cpu() {
    grep "cpu cores" /proc/cpuinfo | uniq | awk -F: '{print $2}'
}

system::memory() {
    free -m | grep "Mem:" | awk '{print $2}'
}

system::swap() {
    free -m | grep "Swap:" | awk '{print $2}'
}

system::disk_size() {
    df -h / | awk '{print $2}' | sed -n '2p'
}

system::system_bit() {
    getconf LONG_BIT
}

system::make_swap() {
    # default is 512 MiB
    size=${1:-512}

    sudo mkdir -p /var/cache/swap/

    # use p to split file name and get index
    max_index=$(ls /var/cache/swap | sort -tp -k 2,2nr | head -1 | cut -dp -f 2)
    next_swap=swap"$((max_index + 1))"

    sudo dd if=/dev/zero of=/var/cache/swap/${next_swap} bs=1M count="$size"
    sudo chmod 0600 /var/cache/swap/${next_swap}
    sudo mkswap /var/cache/swap/${next_swap}
    sudo swapon /var/cache/swap/${next_swap}

    # enable load swap after restart
    echo "/var/cache/swap/${next_swap} none swap sw 0 0" | sudo tee -a /etc/fstab > /dev/null
}
