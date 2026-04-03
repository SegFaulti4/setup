#!/bin/bash
set -eux

./post-0-secrets.sh
./post-1-reclone.sh
./post-2-qmk.sh
./post-3-browsing.sh
./post-4-ide.sh
