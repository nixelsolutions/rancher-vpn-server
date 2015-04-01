#/bin/bash

[ "$DEBUG" == "1" ] && set -x

set -e

export OPENVPN_PATH=/etc/openvpn

export VPN_TYPE=`echo "${VPN_TYPE}" | tr '[:lower:]' '[:upper:]'`

export SSH_OPTS="-p 2222 -o ConnectTimeout=4 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
