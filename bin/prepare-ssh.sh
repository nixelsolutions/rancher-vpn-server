#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

set -e

# Change root password
if [ "${VPN_PASSWORD}" == "**ChangeMe**" ]; then
   echo "ERROR: You did not specify "-e VPN_PASSWORD" environment variable - Exiting..."
   exit 1
fi
echo "root:${VPN_PASSWORD}" | chpasswd
