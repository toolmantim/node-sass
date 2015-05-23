#!/bin/bash

set -e

source ~/.nvm/nvm.sh

wget http://nodejs.org/dist/v0.10.38/node-v0.10.38-linux-x86.tar.gz
tar -C ~/.nvm/versions/node -xvf node-v0.10.38-linux-x86.tar.gz
ln -sf ~/.nvm/versions/node/node-v0.10.38-linux-x86/bin/{npm,node} /bin
npm install
node scripts/build.js -f

wget http://nodejs.org/dist/v0.12.2/node-v0.12.2-linux-x86.tar.gz
tar -C ~/.nvm/versions/node -xvf node-v0.12.2-linux-x86.tar.gz
ln -sf ~/.nvm/versions/node/node-v0.12.2-linux-x86/bin/{npm,node} /bin
node scripts/build.js -f

wget https://iojs.org/dist/v1.0.4/iojs-v1.0.4-linux-x86.tar.gz
tar -C ~/.nvm/versions/io.js -xvf iojs-v1.0.4-linux-x86.tar.gz
ln -sf ~/.nvm/versions/io.js/iojs-v1.0.4-linux-ia32/bin/{npm,node} /bin
node scripts/build.js -f

wget https://iojs.org/dist/v1.8.1/iojs-v1.8.1-linux-x86.tar.gz
tar -C ~/.nvm/versions/io.js -xvf iojs-v1.8.1-linux-x86.tar.gz
ln -sf ~/.nvm/versions/io.js/iojs-v1.8.1-linux-ia32/bin/{npm,node} /bin
node scripts/build.js -f

wget https://iojs.org/dist/v2.0.0/iojs-v2.0.0-linux-x86.tar.gz
tar -C ~/.nvm/versions/io.js -xvf iojs-v2.0.0-linux-x86.tar.gz
ln -sf ~/.nvm/versions/io.js/iojs-v2.0.0-linux-ia32/bin/{npm,node} /bin
node scripts/build.js -f
