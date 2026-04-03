#!/bin/bash
set -eux

./post-00-secrets.sh
./post-01-reclone.sh
./post-02-qmk.sh
./post-03-browsing.sh
./post-04-ide.sh
