#!/bin/bash
set -eux

./00-packages.sh
./01-window-manager.sh
./02-dotfiles.sh
./03-rights.sh
./04-docker.sh
./05-network.sh
