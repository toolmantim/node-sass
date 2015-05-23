#!/bin/bash

# Meant to be run from inside the Docker container

set -e

source ~/.nvm/nvm.sh

nvm install v0.10

npm install

node scripts/build.js -f
