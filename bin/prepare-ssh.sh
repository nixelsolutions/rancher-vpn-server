#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

set -e

# Change root password
if [ "${VPN_PASSWORD}" == "**ChangeMe**" ]; then
   VPN_PASSWORD=`pwgen -s 20 1`
   echo "If you are using nixel/rancher-vpn-client docker image you must define VPN_PASSWORD environment variable with -e \"VPN_PASSWORD=$VPN_PASSWORD\""
fi
echo "root:${VPN_PASSWORD}" | chpasswd
