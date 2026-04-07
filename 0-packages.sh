#!/bin/bash
set -eux

# install packages
sudo apt update
sudo apt -y upgrade

grep -vE '^\s*($|#)' ./0-apt-packages.txt | xargs sudo apt install -y
