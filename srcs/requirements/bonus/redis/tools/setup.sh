#!/bin/bash

sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf
echo <<EOF > /etc/redis/redis.conf
maxmemory 256mb
maxmemory-policy allkeys-lfu
EOF
