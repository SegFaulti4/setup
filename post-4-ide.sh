#!/bin/bash
set -eux

# install IDEs
curl https://download-cdn.jetbrains.com/python/pycharm-professional-2024.3.6.tar.gz --output pycharm.tar.gz && \
sudo tar -C /opt -xzvf pycharm.tar.gz && \
sudo mv /opt/pycharm-* /opt/pycharm && \
rm -f pycharm.tar.gz || true

curl https://download-cdn.jetbrains.com/go/goland-2024.3.6.tar.gz --output goland.tar.gz && \
sudo tar -C /opt -xzvf goland.tar.gz && \
sudo mv /opt/GoLand-* /opt/goland && \
rm -f goland.tar.gz || true

# install micro plugins
micro -plugin install lsp
