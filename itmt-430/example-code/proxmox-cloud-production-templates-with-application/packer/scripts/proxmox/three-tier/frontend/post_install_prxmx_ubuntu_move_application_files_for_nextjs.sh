#!/bin/bash

# Change directory to the location of your Next project code
cd /home/vagrant/team-00/code/nextjs-project/

# Run NPM install to download all dependencies from the package.json
# We don't want to be pushing node_module directory around!
npm install --production

# Use the command: npm run build :to compile the source code
npm run build
