#!/bin/bash
set -eux

sudo groupadd -f docker

MY_USER=$USER
sudo usermod -aG lpadmin $MY_USER
sudo usermod -aG video $MY_USER
sudo usermod -aG input $MY_USER
sudo usermod -aG plugdev $MY_USER
sudo usermod -aG docker $MY_USER

# enable vial support
export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
