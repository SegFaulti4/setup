#!/bin/bash
set -eux

./0-packages.sh
./1-window-manager.sh
./2-dotfiles.sh
./3-rights.sh
./4-docker.sh
./5-network.sh
./6-razer.sh
