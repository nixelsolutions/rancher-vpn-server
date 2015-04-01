#!/bin/bash

[ "$DEBUG" == "1" ] && set -x

set -e

mkdir -p /var/run/sshd 
# Change SSHD Port and remove Password Authentication
perl -p -i -e "s/^Port .*/Port 2222/g" /etc/ssh/sshd_config
perl -p -i -e "s/#?PasswordAuthentication .*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
perl -p -i -e "s/#?PermitRootLogin .*/PermitRootLogin yes/g" /etc/ssh/sshd_config
grep ClientAliveInterval /etc/ssh/sshd_config >/dev/null 2>&1 || echo "ClientAliveInterval 60" >> /etc/ssh/sshd_config

# Change root password
if [ "${VPN_PASSWORD}" == "**ChangeMe**" ]; then
   echo "ERROR: You did not specify "-e VPN_PASSWORD" environment variable - Exiting..."
   exit 1
fi
echo "root:${VPN_PASSWORD}" | chpasswd

# Start SSHD
/usr/sbin/sshd -D
