#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

set -e

source /usr/local/bin/environment.sh

cat $OPENVPN_PATH/.ssh/id_rsa.pub
