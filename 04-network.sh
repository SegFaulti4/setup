#!/bin/bash
set -eux

sudo apt install -y systemd-resolved openvpn3-client openvpn-systemd-resolved network-manager network-manager-gnome network-manager-openpvn
sudo openvpn3-admin netcfg-service --config-set systemd-resolved true
