#!/bin/bash
set -eux

# install openrazer from source
git clone https://github.com/openrazer/openrazer -b stable $HOME/clones/openrazer
cd $HOME/clones/openrazer
./scripts/build_debs.sh
sudo apt install ./dist/*.deb

# start openrazer daemon
systemctl --user start openrazer-daemon.service

# install razer cli
pipx install --system-site-packages razer-cli

# install razergenie
echo 'deb http://download.opensuse.org/repositories/hardware:/razer/Debian_13/ /' | sudo tee /etc/apt/sources.list.d/hardware:razer.list
curl -fsSL https://download.opensuse.org/repositories/hardware:razer/Debian_13/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/hardware_razer.gpg > /dev/null
sudo apt update
sudo apt install razergenie
