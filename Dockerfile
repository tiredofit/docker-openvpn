FROM docker.io/tiredofit/debian:bullseye
LABEL maintainer="Dave Conroy <github.com/tiredofit>"

## Set Defaults
ENV EASYRSA_VERSION=3.0.8 \
    CONTAINER_ENABLE_MESSAGING=FALSE \
    OPENVPN=/etc/openvpn \
    EASYRSA=/usr/share/easy-rsa \
    EASYRSA_PKI=/etc/openvpn/pki \
    EASYRSA_VARS_FILE=/etc/openvpn/vars \
    EASYRSA_CRL_DAYS=3650

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
    curl -sSL https://github.com/OpenVPN/easy-rsa/archive/v${EASYRSA_VERSION}.tar.gz | tar xzf - --strip=2 -C /usr/share/easy-rsa && \
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
