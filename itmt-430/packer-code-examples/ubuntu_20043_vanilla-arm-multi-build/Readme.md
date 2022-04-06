# Steps Needed for M1 Packer/Vagrant build

* Open iterm2 or any terminal program and `cd` to your team repo that was cloned to your M1
  * If you haven't clone it, do that now
  * On your M1 mac - issue the command: `git pull` in your team repo
  * In a seperate terminal tab or window `cd` to the jhajek sample code repo and issue the command: `git pull`
* From jhajek > build directory, copy the file: ubuntu_20043_vanilla-arm-multi-build.pkr.hcl fomr the directory: `ubuntu_20443_vanilla-arm-multi-build` and overwrite the contents of the file in your team repo
  * Note you don't have to copy the template-for-variables.pkr.hcl or subiquity folder
* In an additional new terminal window/tab you need to edit the file: `~/.zprofile`
  * Add this value to the end of that file: `export PYTHONPATH=/Library/Frameworks/ParallelsVirtualizationSDK.framework/Versions/9/Libraries/Python/3.7`
  * Close all of your terminals to make sure that this value has been processed
* From a terminal, type the command: `prlctl --version`
  * You should see: **17.1.2** for the version
  * If not - you need to install the parallels virtualization toolkit
    * `brew install parallels-virtualization-sdk`
* You will need to install the Vagrant Parallels Provider Plugin as well
  * From a terminal type: ```vagrant plugin install vagrant-parallels```
* Now you are ready to build!

## Build Instructions

* From the ubuntu_20043_vanilla-arm-multi-build directory
  * Issue the command: `packer build -parallel-builds=1 .`
  * This will build each of the Vagrant boxes in series
* Copy the directory `M1-project` from the `build` directory
  * Make sure this is at the same level as the `project` directory
* Upon success `cd` into the `bash` directory
  * Issue the command: `chmod +x *.sh`
  * Execute the command: `./m1-remove-and-add-vagrant-boxes.sh`
    * This command will remove and previous Vagrant Boxes and will add the boxes you just built
  * This command is similar to the remove-and-retrieve-and-add-vagrant-boxes.sh for x86 systems, minus the retrieve step
* Once succesful, execute the command `./up.sh` to start each Vagrant Box
  * You can run `./halt.sh` to stop them all
  * You will be able to access your Vagrant Boxes on your M1 by opening a browser and navigating to your Load balancer IP: http://192.168.56.101
