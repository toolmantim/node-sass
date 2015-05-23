#!/bin/bash

# Meant to be run from inside the Docker container

set -e

source ~/.nvm/nvm.sh

wget https://iojs.org/dist/v1.0.4/iojs-v1.0.4-linux-x86.tar.gz

tar -C ~/.nvm/versions/io.js -xvf iojs-v1.0.4-linux-x86.tar.gz

ln -sf ~/.nvm/versions/io.js/iojs-v1.0.4-linux-ia32/bin/{npm,node} /bin

node scripts/build.js -f
