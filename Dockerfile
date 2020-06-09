FROM tiredofit/debian:buster
LABEL maintainer="Dave Conroy <dave at tiredofit dot ca>"

## Set Defaults
ENV ENABLE_SMTP=FALSE \
    OPENVPN=/etc/openvpn \
    EASYRSA=/usr/share/easy-rsa \
    EASYRSA_PKI=/etc/openvpn/pki \
    EASYRSA_VARS_FILE=/etc/openvpn/vars \
    EASYRSA_CRL_DAYS=3650 \
    ZABBIX_HOSTNAME=openvpn-app

##Install Dependencies
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
                iptables \
                openvpn \
                openvpn-auth-ldap \
                && \
    \
    apt-get -y purge easy-rsa && \
    mkdir -p /usr/share/easy-rsa && \
    curl -L https://github.com/OpenVPN/easy-rsa/archive/v3.0.4.tar.gz | tar xzf - --strip=2 -C /usr/share/easy-rsa && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/sbin && \
    \
## Cleanup
    rm -rf /var/log/* && \
    mkdir -p /var/log/openvpn && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/etc/openvpn"]

## Networking Configuration
EXPOSE 1194/udp

## Add File Assets
ADD install /
