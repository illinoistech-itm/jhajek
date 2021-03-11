# Installation Instruction

Place all instruction needed to build your entire application here

From the build-scripts directory:

* Make a copy of the file: `variables-sample.json` and rename it to `variables.json`
  * Modify the values in `variables.json`

`packer build --var-file ./variables.json ./ubuntu18045-sample-server.json`
