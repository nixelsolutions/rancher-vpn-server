#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

export VPN_PATH

prepare-ssh.sh
prepare-vpn.sh

/usr/bin/supervisord
