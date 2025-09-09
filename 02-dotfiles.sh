#!/bin/bash
set -eux

# install dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply SegFaulti4

# enable sway local overrides
mkdir -p .config/sway
echo "include hosts/$(hostname).conf" | tee -a .config/sway/.local

# install fonts
sudo fc-cache -f -v $HOME/.local/share/fonts

# enable waybar keyboard module
sudo usermod -aG input popovms
