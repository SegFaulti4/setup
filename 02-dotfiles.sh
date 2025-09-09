#!/bin/bash
set -eux

# install dotfiles
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin init --apply SegFaulti4

# install fonts
sudo fc-cache -f -v $HOME/.local/share/fonts
