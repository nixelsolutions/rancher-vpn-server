#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

SSH_OPTS="-p 2222 -o ConnectTimeout=4 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
my_public_ip=`dig -4 @ns1.google.com -t txt o-o.myaddr.l.google.com +short | sed "s/\"//g"`

# Change root password
if [ "${VPN_PASSWORD}" == "**ChangeMe**" ]; then
   export VPN_PASSWORD=`pwgen -s 20 1`
fi

prepare-ssh.sh
prepare-vpn.sh

echo "==========================================="
echo "If you are using nixel/rancher-vpn-client docker image you must run rancher-vpn-client container using the following docker command:"
echo "sudo docker run -ti -d --privileged --name rancher-vpn-client -e VPN_SERVERS=$my_public_ip:1194 -e VPN_PASSWORD=${VPN_PASSWORD} nixel/rancher-vpn-client:latest"
echo
echo "Then execute \"sudo docker logs rancher-vpn-client\" so you can view the ip route you need to add in your system in order to reach rancher network"
echo "==========================================="
echo "If you are using another OpenVPN client (for example for mobile devices) you can get the VPN client configuration executing this command from your PC:"
echo "sshpass -p ${VPN_PASSWORD} ssh $SSH_OPTS root@$my_public_ip \"get_vpn_client_conf.sh $my_public_ip:1194\" > RancherVPNClient.ovpn"
   echo "==========================================="

/usr/bin/supervisord
