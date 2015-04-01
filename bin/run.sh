#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

set -e

source /usr/local/bin/environment.sh

case "${VPN_TYPE}" in
   SERVER)
      echo "This VPN is a SERVER instance... running prepare_ssh_server.sh and prepare_vpn_server.sh"
      prepare_ssh_server.sh
      prepare_vpn_server.sh
      ;;
   CLIENT)
      echo "This VPN is a CLIENT instance... running prepare_vpn_client.sh"
      prepare_vpn_client.sh
      ;;
   *)
      echo "ERROR: you must pass -e VPN_TYPE=SERVER or -e VPN_TYPE=CLIENT to this container"
      exit 1
      ;;
esac

# Open a console
bash
