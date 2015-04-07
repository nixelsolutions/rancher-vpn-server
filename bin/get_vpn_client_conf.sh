#!/bin/bash

set -e

VPN_PATH=/etc/openvpn

# Extract remote nodes
VPN_SERVERS="$1"
if [ "${VPN_SERVERS}" == "**ChangeMe**" ] || [ -z ${VPN_SERVERS} ]; then
   echo "ERROR: You did not specify VPN Servers to connect to, please enter VPN Servers as an argument."
   echo "You may specify more than one server separated by a comma, for example: $0 X.X.X.X:1194,Y.Y.Y.Y:1194"
   echo "Exiting..."
   exit 1
fi
OVPN_SERVERS=`echo ${VPN_SERVERS} | sed "s/^/remote /g" | sed "s/,$//g" | sed "s/,/\nremote /g" | sed "s/:/ /g"`

# Extract ca.crt
CA_CRT=`cat $VPN_PATH/easy-rsa/keys/ca.crt`
CLIENT_CRT=`cat $VPN_PATH/easy-rsa/keys/RancherVPNClient.crt`
CLIENT_KEY=`cat $VPN_PATH/easy-rsa/keys/RancherVPNClient.key`
TA_KEY=`cat $VPN_PATH/easy-rsa/keys/ta.key`

cat > $VPN_PATH/RancherVPNClient.ovpn <<EOF
$OVPN_SERVERS
remote-random
client
dev tun
proto tcp
resolv-retry infinite
nobind
comp-lzo

;user nobody
;group nogroup 

;log-append  /var/log/openvpn.log
verb 3

persist-key
persist-tun

key-direction 1

<ca>
$CA_CRT
</ca>

<cert>
$CLIENT_CRT
</cert>

<key>
$CLIENT_KEY
</key>

<tls-auth>
$TA_KEY
</tls-auth>
EOF

chmod 600 $VPN_PATH/RancherVPNClient.ovpn
cat $VPN_PATH/RancherVPNClient.ovpn
