#!/bin/bash
set -eux

# add sway launch script
sudo mkdir -p /usr/local/bin
sudo cp -f ./assets/start-sway /usr/local/bin/start-sway
sudo chmod 0755 /usr/local/bin/start-sway

# apply greetd config
sudo mkdir -p /etc/greetd
sudo cp -f ./assets/greetd.toml /etc/greetd/config.toml
