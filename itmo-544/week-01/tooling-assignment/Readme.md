# ITMO 544 Tooling Assignments

In this exercise we will install tools needed to be able to accomplish our jobs during the semester.  The first thing we need to do is install a package manager for MacOS and or Windows 10. Then we will install modern opensource shell software and then the Git-SCM version control tool we will need for the semester to submit our work.  

**Deliverable:** Complete the necessary install steps for either MacOS or Windows10 and supply the requested screenshots below each header.  To submit this Readme.md file, in your private repo provided to you, under the itmo-544 folder, create a folder named: **week-01**, then a folder under that named: **tooling-assignment**.  Push your Readme.md (this file) to that location.

## Package Managers for Windows

There are two package managers for Windows 10. [Chocolatey.org](https://chocolatey.org/ "Chocolatey.org download page") is the Windows 3rd party package manager.  [Winget](https://devblogs.microsoft.com/commandline/windows-package-manager-1-0/ "Winget Instal URL") is the Microsoft first party package manager. Place a screenshot of the version command output for wither: `winget -v` or `choco -v`

## Installation of PowerShell Core for Windows

Using Chocolatey (choco) or Winget install [PowerShell Core 7.1.x](https://chocolatey.org/packages/powershell-core "PowerShell Core 7 Download from choco").  Place a screenshot of the initial PowerShell 7 screen.  Add screenshot of the output of: ```ssh -V```.  

## Installation of a Terminal for Windows

A Terminal is a way to run multiple shell and cmd line windows in a single managed window.  On Windows install Microsoft Terminal from either place:

* [Windows Terminal Microsoft Store Install](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab "Install Windows Terminal from Microsoft Store")
* [Chocolatey](https://community.chocolatey.org/packages/microsoft-windows-terminal/1.9.1942.0 "Chocolatey Windows Terminal Install URL") - `choco install microsoft-windows-terminal`
* `winget install terminal`

## Install Git for Windows

Using the package manager of your choice, install the Git Client if you do not already have it installed.  **Note**, this is different from the GitHub Desktop tool, which we will not be using this semester (which is a fine piece of software).

Place a screenshot of the output of the command: ```git --version```

You will need to configure Git if you already haven't done so.  From a shell run these two commands:

```bash

git config --global user.name "<Your Name>"
git config --global user.email "<youremail@example.com>"
```

## Install IDE editor

After installing an IDE editor of your choice, pick one of the listed or you can use another one, but it needs to have native Git support built into the editor.  Take a screenshot of output of the help > about button in the application.  You can install all or any of these via the package managers Chocolatey or Winget.

* [VSCode from Microsoft](https://code.visualstudio.com/ "VSCode install")
  * Cross platform and has direct shell integration
* [atom.io](https://atom.io/ "Atom.io install")
  * Built by GitHub for Git integration
* [Sublime Text](http://www.sublimetext.com/ "Submlime Text installer site")
  * Built for a MacOS native experience, A sophisticated text editor for code, markup and prose.  Available for all platforms.
* [Adobe Brackets](http://brackets.io/ "Adobe Brackets Install")
  * Cross Platform development tool from Adobe
* Or any other IDE that has native Git integration

## Packer Managers for MacOS

Brew is the MacOS 3rd party package manager located at: [https://brew.sh/](https://brew.sh/ "brew installer page"). Place a screenshot of the output of ```brew --version```.

## Installation of Bash 5 on MacOS

Using Homebrew install Bash 5.0+ on MacOS and activate it to replace Bash 3.x
[https://www.ioannispoulakas.com/2019/03/10/how-to-install-bash-5-on-macos/](https://www.ioannispoulakas.com/2019/03/10/how-to-install-bash-5-on-macos/ "Replace Bash 3 with 5 MacOS"). For Mac, if you have Bash and SSH already installed, take a screenshot of the output of ```ssh -V``` and ```bash --version```

## Installation of a Terminal for MacOS

A Terminal is a way to run multiple shell and cmd line windows in a single managed window.  You can install iterm2 via Homebrew.

[iterm2](https://iterm2.com/ "MacOS shell terminal")

## Install Git for MacOS

Using the package manager from the previous step, install the Git Client if you do not already have it installed.  **Note**, this is different from the GitHub Desktop tool, which we will not be using this semester.
Place a screenshot of the output of the command: ```git --version```

You will need to configure Git if you already haven't done so.  From a shell run these two commands:

```bash

git config --global user.name "<Your Name>"
git config --global user.email "<youremail@example.com>"
```

## Install IDE editor MacOS

After installing an IDE editor of your choice, pick one of the listed or you can use another one, but it needs to have native Git support built into the editor.  Take a screenshot of output of the help > about button in the application.  You can install all or any of these via the package manager brew.

* [VSCode from Microsoft](https://code.visualstudio.com/ "VSCode install")
  * Cross platform and has direct shell integration
* [atom.io](https://atom.io/ "Atom.io install")
  * Built by GitHub for Git integration
* [Sublime Text](http://www.sublimetext.com/ "Submlime Text installer site")
  * Built for a MacOS native experience, A sophisticated text editor for code, markup and prose.  Available for all platforms.
* [Adobe Brackets](http://brackets.io/ "Adobe Brackets Install")
  * Cross Platform development tool from Adobe
* Or any other IDE that has native Git integration
