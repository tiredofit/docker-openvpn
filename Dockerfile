FROM tiredofit/alpine:3.8
LABEL maintainer="Dave Conroy <dave@tiredofit.ca>"

## Set Defaults
ENV ENABLE_SMTP=FALSE \
    OPENVPN=/etc/openvpn \
    EASYRSA=/usr/share/easy-rsa \
    EASYRSA_PKI=/etc/openvpn/pki \
    EASYRSA_VARS_FILE=/etc/openvpn/vars \
    EASYRSA_CRL_DAYS=3650 \
    ZABBIX_HOSTNAME=openvpn-app

##Install Dependencies
RUN apk update && \
    apk add --force-overwrite -t .openvpn-run-deps \
        easy-rsa \
        google-authenticator \
        iptables \
        openvpn \
        openvpn-auth-pam \
        openvpn-auth-ldap \
        && \
    \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    \
## Cleanup
    mkdir -p /var/log/openvpn && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

VOLUME ["/etc/openvpn"]

## Networking Configuration
EXPOSE 1194/udp

## Add File Assets
ADD install /
