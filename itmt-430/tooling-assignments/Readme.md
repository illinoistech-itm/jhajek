# Tooling Setup Assignment

In this assignment there will be a series of tools you need to install and complete small tutorials.  Copy this Markdown document and insert screenshots of the software installed.

## Installation of Powershell Core for Windows

If you have a Windows 10 system, make sure that the native SSH client and [PowerShell Core 6](https://github.com/PowerShell/PowerShell/releases/tag/v6.2.3 "PowerShell Core 6 Download") are installed.  Add screenshot of the output of: ```ssh -V``` and open the PowerShell 6 (darkblue screen) and the version is shown in the top line.   For Mac, you have Bash and SSH already installed, place a screenshot of the output of ```ssh -V``` and ```bash --version```

## Package Managers for Windows and MacOS

Brew is the MacOS 3rd party package manager located at: [https://brew.sh/](https://brew.sh/ "brew installer page").  [Chocolatey.org](https://chocolatey.org/ "Chocolatey.org download page") is the Windows 3rd party package manager.  Place screenshot of the version command output for: ```chocolatey --version``` or ```brew --version```

## Install Git

Using the package manager from the previous step, install the Git Client if you do not already have it installed.  **Note**, this is different from the GitHub Desktop tool, which we will not be using this semester.
Place a screenshot of the output of the command: ```git --version```

You will need to configure Git if you already haven't done so.  From a shell run these two commands:

```bash

git config --global user.name "<Your Name>"
git config --global user.email "<youremail@example.com>"
```

## Install VirtualBox

If you do not already have VirtualBox 6.x installed, use the package manager to install VirtualBox.  Take a screenshot of the VirtualBox > Help > About VirtualBox output.

## Install Vagrant

Using a package manager, install the latest version of [Vagrant](https://vagrantup.com "Vagrant download site").  If you have a version 2.2.x you will be ok.  Note, if on Linux, do not use the built in package manager as these versions of Vagrant and Packer are too old and unmaintained.  Place a screenshot of the output of the command: ```vagrant --version```

## Install Packer.io

Using a package manager, install the latest version of [Packer](https://packer.io "Packer install site").  If you have a version > 1.4.x you will be ok. Note, if on Linux, do not use the built in package manager as these versions of Vagrant and Packer are too old and unmaintained.  Place a screenshot of the output of the command: ```packer --version```

## Install IDE editor

After installing an IDE editor of your choice, pick one of the listed or you can use another one, but it needs to have native Git support built into the editor.  Take a screenshot of output of the help > about button in the application.  You can install all or any of these via the package managers Chocolatey and Brew.

* [VSCode from Microsoft](https://code.visualstudio.com/ "VSCode install")
  * Cross platform and has direct shell integration
* [atom.io](https://atom.io/ "Atom.io install")
  * Built by GitHub for Git integration
* [Sublime Text](http://www.sublimetext.com/ "Submlime Text installer site")
  * Built for a MacOS native experience, A sophisticated text editor for code, markup and prose.  Available for all platforms.
* [Adobe Brackets](http://brackets.io/ "Adobe Brackets Install")
  * Cross Platform development tool from Adobe

## Git-It Tutorial

Download, extract, and execute the Git-It tutorial, located: [https://github.com/jlord/git-it-electron/releases](https://github.com/jlord/git-it-electron/releases "Git-It release tutorial").  The program runs as an executable so there is no installation needed.  The program does require you to have completed and configured Git, which we did in a previous step.  

## Create and Push your Readme.md

Push to your repo your intro Readme.md  

