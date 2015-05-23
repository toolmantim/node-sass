#!/bin/bash

# Meant to be run from inside the Docker container

# Usage: scripts/build/64bit.sh <version>
#
# Examples:
#   scripts/build/64bit.sh v0
#   scripts/build/64bit.sh v0.10
#   scripts/build/64bit.sh v0.10
#   scripts/build/64bit.sh iojs-v1

set -eu

source ~/.nvm/nvm.sh && nvm use $1

node scripts/build.js -f
