#!/bin/bash
set -eux

# install qmk
git clone git@github.com:SegFaulti4/qmk_firmware.git $HOME/qmk_firmware && \
git --git-dir=$HOME/qmk_firmware/.git remote add upstream git@github.com:qmk/qmk_firmware
sudo cp $HOME/qmk_firmware/util/udev/50-qmk.rules /etc/udev/rules.d/
qmk setup -y || true
git --git-dir=$HOME/qmk_firmware/.git checkout current
