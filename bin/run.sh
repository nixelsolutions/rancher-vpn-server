#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

prepare-ssh.sh
prepare-vpn.sh

/usr/bin/supervisord
