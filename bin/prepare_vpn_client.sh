#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

set -e

# Extract remote nodes
if [ "${VPN_SERVERS}" == "**ChangeMe**" ]; then
   echo "ERROR: You did not specify "-e VPN_SERVERS" environment variable - Exiting..."
   exit 1
fi
OVPN_SERVERS=`echo ${VPN_SERVERS} | sed "s/^/remote /g" | sed "s/,$//g" | sed "s/,/\nremote /g" | sed "s/:/ /g"`

if [ "${VPN_PASSWORD}" == "**ChangeMe**" ]; then
   echo "ERROR: You did not specify "-e VPN_PASSWORD" environment variable - Exiting..."
   exit 1
fi

mkdir -p /etc/openvpn
rm -f $OPENVPN_PATH/easy-rsa/keys/RancherVPNClient.conf
# Try to get OpenVPN config from any of listed servers
for SERVER in `echo ${VPN_SERVERS} | sed "s/,/ /g"`; do
    SERVER=`echo $SERVER | awk -F: '{print $1}'`
#    if sshpass -p ${VPN_PASSWORD} ssh $SSH_OPTS root@$SERVER "get_vpn_client_conf.sh ${VPN_SERVERS}"; then
#       rsync -avz --rsh="sshpass -p ${VPN_PASSWORD} ssh -l root $SSH_OPTS" $SERVER:$OPENVPN_PATH/easy-rsa/keys/RancherVPNClient.conf $OPENVPN_PATH/
#       break
#    fi
    sshpass -p ${VPN_PASSWORD} ssh $SSH_OPTS root@$SERVER "get_vpn_client_conf.sh ${VPN_SERVERS}" > $OPENVPN_PATH/RancherVPNClient.conf
done

# Start openvpn
#service openvpn start
