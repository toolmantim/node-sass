#!/bin/bash

# Meant to be run from inside the Docker container

set -e

source ~/.nvm/nvm.sh

wget http://nodejs.org/dist/v0.10.38/node-v0.10.38-linux-x86.tar.gz

tar -C ~/.nvm/versions/node -xvf node-v0.10.38-linux-x86.tar.gz

ln -sf ~/.nvm/versions/node/node-v0.10.38-linux-x86/bin/{npm,node} /bin

npm install

node scripts/build.js -f