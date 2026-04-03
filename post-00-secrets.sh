#!/bin/bash
set -eux

# set correct rights for secret files
chmod 0644 $HOME/secrets/*.*
chmod 0644 $HOME/secrets/*/*
chmod 0400 $HOME/secrets/*/id_*

chmod 0644 $HOME/.ssh/*
chmod 0400 $HOME/.ssh/id_*
chmod 0644 $HOME/.ssh/id_*.pub
