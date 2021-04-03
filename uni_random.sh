#!/usr/bin/env bash

source common.sh

port="${1:-80}"
count="${2:-10000}"

nmap_random "$port" "$count" | while read -r ip; do
    echo $ip
done

