#!/bin/bash

sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g'
echo <<EOF
maxmemory 256mb
maxmemory-policy allkeys-lfu
EOF
redis-server --protected-mode no