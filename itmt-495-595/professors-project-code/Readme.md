# Instructions to build

This command shows how to build the 4 node Load Balanced NodeJS app

`packer build --var-file=./variables.json web-application-parallel-build.json`

The `--var-file` option tells Packer to read the ENV variables set in this file and parse them while building the .json build template.  Approximately line 244-250

## --only

You can use the --only commandline flag to build only select boxes

`packer build --var-file=./variables.json --only=mm,ms1,ms2 web-application-parallel-build.json`

## Packer User Variables

You can pass variables at runtime to dynamically change settings.  As the number of systems increase, you may want to go headless (no gui) or increase/reduce the amount of ram allocated at build time.

`packer build --var-file=./variables.json -var 'headless=true' -var 'memory=1024' web-application-parallel-build.json`

Packer allows you to set defaults so if you don't pass any runtime values the script will still work.  This example will run the installs headless and give each virtual machine 2gb or 2048mb while being installed.

See the `web-application-parallel-build.json` for an example and the Packer documentation: [https://www.packer.io/docs/templates/user-variables](https://www.packer.io/docs/templates/user-variables "Packer.io user variables documentation")

## Automate the entire build process

The above command will be executed along with the `vagrant add` command using the script: `build-and-add-boxes.ps1` located in the directory: `creation-scripts`

You can pass positional parameters to the `build-and-add-boxes.ps1` script:  `.\build-and-add-boxes.ps1 -Headless true -Memory 1024`

## Accessing Application

Open a web browser and navigate to http://192.168.33.200  and refresh browser multiple times you will see three messages as the NodeJS applications are rotated through.
