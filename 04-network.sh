#!/bin/bash
set -eux

sudo apt install -y systemd-resolved openvpn3-client openvpn-systemd-resolved \
  network-manager network-manager-gnome network-manager-openpvn network-manager-openpvn-gnome network-manager-ssh network-manager-ssh-gnome
sudo openvpn3-admin netcfg-service --config-set systemd-resolved true
