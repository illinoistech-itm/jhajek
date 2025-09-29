# Lab - Chapter 03

Use the provided template for submitting your screenshots as part of the deliverable.

## Objectives

* Explore installing multiple types of Operating Systems
* Explore the installation process using .ISO files

## Outcomes

At the conclusion of this lab you will have installed ~10-20 Linux based operating system distributions (distros) as Virtual Machines. You will have mastered the installation process and been exposed to various Linux operating systems.

### Virtual Machine Creation - part I

Following the demonstrations in section 3.6.3 and the installation information in section 3.6.1, you will need to find the download links for the Linux and BSD ISOs listed. You will need to install the latest version of [VirtualBox 7.x](https://virtualbox.org "VirtualBox Download site") in order to complete this exercise. 

If you are using an M-series Mac, you will need to purchase a copy of a comparable software called [Parallels Virtualization for Apple Silicon Macs](https://www.parallels.com/ "Parallels virtualization for M1 Mac").

Complete each install fully and then using the correct package manager install the program `fastfetch` or `neofetch` and take a screenshot of the results. There are 15 different distributions listed for Intel based x86 Windows and Macs. There are 11 different distributions listed for M-series Mac Hardware. If a version number is not listed, assume the latest version.

#### Parallels

If you are using `Parallels` complete the necessary installs and adjust VirtualBox deliverables where appropriate.

### Screenshots

For those using x86_64 Intel Windows and Macs install the following ISOs, install the package `fastfetch` or `neofetch` via the package manger and take a screenshot of the results adding them to the document below each unit.

* Debian Based operating systems
  * `sudo apt update`
  * `sudo apt install fastfetch`
  * or `sudo apt install neofetch`

* RedHat based operating systems
  * `sudo dnf install epel-release`
  * `sudo dnf install fastfetch`

* Debian Based Operating Systems
  * Ubuntu Desktop edition
  * Lubuntu Desktop edition
  * Ubuntu Server edition
  * Trisquel Linux
  * Xebian
  * Ubuntu KDE Neon

* Red Hat Based
  * Fedora Workstation edition
  * AlmaLinux

* BSD based
  * FreeBSD

* Linux
  * MX Linux
  * Pop!_OS
  * Kali Linux
  * Manjaro Linux (SteamOS is based on)

* Network Based Install
  * openSUSE Leap
  * Debian

* Windows 11

For those using Parallels virtualization on [Apple Silicon](https://en.wikipedia.org/wiki/Apple_silicon "wiki article for Apple Silicon") -- look for the `aarch` or `arm` distribution, NOT `amd_64`.

* Debian Based ARM
  * Ubuntu Desktop edition
  * Ubuntu Server edition
  * Peppermint OS

* Red Hat Based ARM
  * Fedora Workstation edition 
  * AlmaLinux
  * Rocky Linux

* BSD based ARM
  * FreeBSD

* Other Linux Distros ARM
  * Kali Linux
  * Rhino Linux

* Network Based Install ARM
  * openSUSE Leap
  * Debian

* Windows 11

#### Deliverable

Create a folder in your local repo under the `itm-303` folder named: `labs`. Create a sub-folder under this folder named: `module-07`. Push this template and the corresponding images to your private GitHub repo. Submit the URL to that document as your Canvas deliverable.
