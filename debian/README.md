# hub.docker.com/tiredofit/openvpn

# Introduction

Dockerfile to build an [OpenVPN](https://www.openvpn.net) container image to scan files or most commonly, mail messages.

* Customized to Allow LDAP Authentication

* This Container uses a [customized Debian base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, nano, vim) for easier management. 



[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](https://github.com/tiredofit/)

# Table of Contents

- [Introduction](#introduction)
    - [Changelog](CHANGELOG.md)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Environment Variables](#environmentvariables)   
- [Details](#details)

- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
   - [References](#references)

# Prerequisites

None.

# Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/tiredofit/openvpn) and is the recommended method of installation.


```bash
docker pull hub.docker.com/tiredofit/openvpn:(imagetag)
```

The following image tags are available:
* `alpine-latest` - Most recent release of Openvpn w/Alpine 3.8
* `latest` - Most recent release of Openvpn w/Debian Stretch

# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.

* Start the Container and for the first time let the certificates generate
* Create a new user by entering into the container and typing `ovpn_createclient` and then copying the created file from your data directory to the client.

# Configuration

### Data-Volumes

The following directories are used for configuration and can be mapped for persistent storage.

| Directory | Description |
|-----------|-------------|
| `/etc/openvpn` | Datab |
| `/var/log/openvpn` | Log Files |

### Environment Variables

Along with the Environment Variables from the [Base image](https://hub.docker.com/r/tiredofit/alpine), below is the complete list of available options that can be used to customize your installation.

| Parameter | Description |
|-----------|-------------|
| `HOSTNME` | Set the Hostname of the VPN Server for Certificate Generation |
| `ENABLE_LDAP` | Enable LDAP Lookup Support `TRUE` or `FALSE` - Default `FALSE` |
| `LDAP_URI` | URI of Ldap Server example 'ldap://ldap.example.com:389` |
| `LDAP_BASE_DN` | BaseDN for Lookups eg `dc=example,dc=com` |
| `LDAP_BIND_USER` | Bind Username for LDAP|
| `LDAP_BIND_PASS` | Password for above username |
| `LDAP_FOLLOW_REFERRALS` | LDAP Follow Referrals `yes` or `no` - Default `yes` |
| `LDAP_TIMEOUT` | Timeout in seconds for LDAP - Default `15` |
| `LDAP_SEARCH_FILTER` | Search filter e.g `(&(uid=%u))`
| `LDAP_REQUIRE_GROUP` | Require a Group to Login `true` / `false` - Default `false` |
| `LDAP_GROUP_BASE_DN` | LDAP Group Base DN e.g. `ou=groups,dc=example,dc=com` |
| `LDAP_GROUP_ATTRIBUTE` | Group Attribute Default `uniqueMember` |
| `LDAP_GROUP_SEARCH_FILTER` | Group search filter ie `(|(cn=developers)(cn=artists))` |


    LDAP_FOLLOW_REFERRALS=${LDAP_FOLLOW_REFERRALS:-yes}
    LDAP_TIMEOUT=${LDAP_TIMEOUT:-15}
    LDAP_REQUIRE_GROUP=${LDAP_REQUIRE_GROUP:-false}
    LDAP_GROUP_SEARCH_FILTER=${LDAP_GROUP_SEARCH_FILTER:-"(|(cn=developers)(cn=artists))"}
    LDAP_GROUP_BASE_DN=${LDAP_GROUP_BASE_DN:-$LDAP_BASE_DN}
    LDAP_GROUP_ATTRIBUTE=${LDAP_GROUP_ATTRIBUTE:-uniqueMember}


### Networking

| Port | Description |
|-----------|-------------|
| `1194/udp`    | Openvpn Listening Port |

# Maintenance

#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it (whatever your container name is e.g. openvpn) bash
```

# References

* https://www.openvpn.net
