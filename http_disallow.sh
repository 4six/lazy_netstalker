#!/usr/bin/env bash
# Harvest http server hosts
# potentially not listed in search engines

source common.sh

TOTAL_HOSTS=${1:-10000}
NMAP_GEN="nmap_random 80 $TOTAL_HOSTS"

check_ip() {
    local ip="$1"
    local url="http://$ip/robots.txt"

    if $GET "$url" | grep '^Disallow: /$' > /dev/null; then
        echo $ip
    fi
}

export -f check_ip

echoerr Harvesting $TOTAL_HOSTS hosts...

hosts=$($NMAP_GEN)
harvested_count=$(echo "$hosts" | wc -l)

echoerr Matching $harvested_count hosts...

echo "$hosts" | xargs -d '\n' -P8 -n1 bash -c 'check_ip "$@"' _

echoerr Done.
