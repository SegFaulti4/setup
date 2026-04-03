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
