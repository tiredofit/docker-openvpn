# hub.docker.com/r/tiredofit/openvpn

[![Build Status](https://img.shields.io/docker/build/tiredofit/openvpn.svg)](https://hub.docker.com/r/tiredofit/openvpn)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/openvpn.svg)](https://hub.docker.com/r/tiredofit/openvpn)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/openvpn.svg)](https://hub.docker.com/r/tiredofit/openvpn)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/openvpn.svg)](https://microbadger.com/images/tiredofit/openvpn)
[![Image Size](https://img.shields.io/microbadger/image-size/tiredofit/openvpn.svg)](https://microbadger.com/images/tiredofit/openvpn)

# Introduction

Dockerfile to build an [OpenVPN](https://www.openvpn.net) server container image to provide VPN services and connect 2 or more computers securely over the internet.

* This Container uses a [customized Alpine base](https://hub.docker.com/r/tiredofit/alpine) which includes [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 Init capabilities, [zabbix-agent](https://zabbix.org) for individual container monitoring, Cron also installed along with other tools (bash,curl, less, logrotate, nano, vim) for easier management. 



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
* `latest` - Most recent release of Openvpn w/Alpine Linux 3.8

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
