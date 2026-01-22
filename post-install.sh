#!/bin/bash
set -eux

# enable vial support
export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/99-vial.rules && udevadm control --reload && udevadm trigger'

# set correct rights for secret files
chmod 0644 $HOME/secrets/*.*
chmod 0644 $HOME/secrets/*/*
chmod 0400 $HOME/secrets/*/id_*

chmod 0644 $HOME/.ssh/*
chmod 0400 $HOME/.ssh/id_*
chmod 0644 $HOME/.ssh/id_*.pub

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
git --git-dir=$HOME/qmk_firmware/.git checkout current

# install browser
sudo install -d -m 0755 /etc/apt/keyrings
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

cat <<EOF | sudo tee /etc/apt/sources.list.d/mozilla.sources
Types: deb
URIs: https://packages.mozilla.org/apt
Suites: mozilla
Components: main
Signed-By: /etc/apt/keyrings/packages.mozilla.org.asc
EOF

echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

sudo apt update && sudo apt install firefox firefox-l10n-ru

# install messenger
curl https://td.telegram.org/tlinux/tsetup.6.1.3.tar.xz --output tsetup.tar.xz && \
sudo tar -C /opt -xJvf tsetup.tar.xz && \
rm -f tsetup.tar.xz || true

# install IDE
curl https://download-cdn.jetbrains.com/python/pycharm-professional-2024.3.6.tar.gz --output pycharm.tar.gz && \
sudo tar -C /opt -xzvf pycharm.tar.gz && \
sudo mv /opt/pycharm-* /opt/pycharm && \
rm -f pycharm.tar.gz || true

# install office
flatpak install -y flathub org.onlyoffice.desktopeditors
