#!/bin/bash

system::cpu() {
    echo $(cat /proc/cpuinfo | grep "cpu cores" | uniq | awk -F: '{print $2}')
}

system::memory() {
    echo $(free -m | grep "Mem:" | awk '{print $2}')
}

system::swap() {
    echo $(free -m | grep "Swap:" | awk '{print $2}')
}

system::disk_size() {
    echo $(df -h / | awk '{print $2}' | sed -n '2p')
}

system::system_bit() {
    echo $(getconf LONG_BIT)
}

system::make_swap() {
    # default is 512 MiB
    size=${1:-512}

    sudo mkdir -p /var/cache/swap/

    # use p to split file name and get index
    max_index=$(cd /var/cache/swap/ | ls | sort -tp -k 2,2nr | head -1 | cut -dp -f 2)
    next_swap=swap"$(($max_index + 1))"

    sudo dd if=/dev/zero of=/var/cache/swap/${next_swap} bs=1M count=$size
    sudo chmod 0600 /var/cache/swap/${next_swap}
    sudo mkswap /var/cache/swap/${next_swap}
    sudo swapon /var/cache/swap/${next_swap}

    # enable load swap after restart
    sudo echo "/var/cache/swap/${next_swap} none swap sw 0 0" >>/etc/fstab
}
