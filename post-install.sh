#!/bin/bash
set -eux

# reclone setup
mkdir -p $HOME/clones && \
rm -rf $HOME/clones/setup && \
git clone git@github.com:SegFaulti4/setup.git $HOME/clones/setup || true

# reclone dotfiles
mkdir -p $HOME/.local/share
rm -rf $HOME/.local/share/chezmoi && \
git clone git@github.com:SegFaulti4/dotfiles.git $HOME/.local/share/chezmoi || true

# install qmk
git clone git@github.com:SegFaulti4/qmk_firmware.git $HOME/qmk_firmware && \
git --git-dir=$HOME/qmk_firmware/.git remote add upstream git@github.com:qmk/qmk_firmware
sudo cp $HOME/qmk_firmware/util/udev/50-qmk.rules /etc/udev/rules.d/
qmk setup -y || true

# install messenger
curl https://td.telegram.org/tlinux/tsetup.6.1.3.tar.xz --output tsetup.tar.xz && \
sudo tar -C /opt -xJvf tsetup.tar.xz && \
rm -f tsetup.tar.xz || true

# install browser
curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output chrome.deb && \
sudo apt install -y ./chrome.deb && \
rm -f chrome.deb || true

# install IDE
curl https://download-cdn.jetbrains.com/python/pycharm-2025.2.1.1.tar.gz --output pycharm.tar.gz && \
sudo tar -C /opt -xzvf pycharm.tar.gz && \
sudo mv /opt/pycharm-* /opt/pycharm && \
rm -f pycharm.tar.gz || true

# enable vial support
sudo usermod -aG input popovms
export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'
