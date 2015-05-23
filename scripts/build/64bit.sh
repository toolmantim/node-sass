#!/bin/bash

set -e

source ~/.nvm/nvm.sh

nvm install v0
npm install
node scripts/build.js -f

nvm install v0.10
node scripts/build.js -f

nvm install iojs-v1
node scripts/build.js -f

nvm install iojs-v2
node scripts/build.js -f

nvm install iojs-v1.0
node scripts/build.js -f
