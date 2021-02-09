# Instructions to build

This command shows how to build the 4 node Load Balanced NodeJS app

`packer build -var-file ./variables.json web-application-parallel-build.json`

The `-var-file` option tells Packer to read the ENV variables set in this file and parse them while building the .json build template.  Approximately line 244-250

## Automate the entire build process

The above command will be executed along with the `vagrant add` command using the script: `build-and-add-boxes.ps1` located in the directory: `creation-scripts`
