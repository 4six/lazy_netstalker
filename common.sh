CURL_TIMEOUT=5

export GET="curl -s -m $CURL_TIMEOUT"

export NMAP_TUNE='--host-timeout 1s --min-rate 1024 --max-retries 2'

echoerr() { echo "$@" 1>&2; }

nmap_random() {
    BL_IPS='10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,224-255.-.-.-'
    local port="$1"
    local total="${2:-10000}"

    nmap -n -P0 -T4 $NMAP_TUNE \
        --open -iR $total \
        --exclude $BL_IPS -p $port -oG - 2>/dev/null \
        | grep '/open' | tr -s ' ' | cut -d ' ' -f 2
}
