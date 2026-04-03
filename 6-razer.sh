#!/bin/bash
set -eux

# install openrazer from source
git clone https://github.com/openrazer/openrazer -b stable $HOME/clones/openrazer
cd $HOME/clones/openrazer
./scripts/build_debs.sh
sudo apt install ./dist/*.deb

systemctl --user start openrazer-daemon.service

pipx install --system-site-packages razer-cli
