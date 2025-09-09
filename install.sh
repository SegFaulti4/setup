#!/bin/bash
set -eux

./00-packages.sh
./01-window-manager.sh
./02-dotfiles.sh
./03-docker.sh
./04-network.sh
