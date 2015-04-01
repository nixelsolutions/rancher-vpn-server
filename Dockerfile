FROM ubuntu:14.04

MAINTAINER Manel Martinez <manel@nixelsolutions.com>

RUN apt-get update && \
    apt-get install -y openssh-server openvpn easy-rsa iptables rsync ipcalc sshpass

ENV VPN_TYPE **ChangeMe**
ENV VPN_SERVERS **ChangeMe**
ENV VPN_PASSWORD **ChangeMe**
ENV DEBUG 0

VOLUME ["/etc/openvpn"]

EXPOSE 2222/tcp
EXPOSE 1194/udp

WORKDIR /etc/openvpn

RUN mkdir -p /usr/local/bin
ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/*.sh

CMD ["run.sh"]
