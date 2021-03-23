% Docker in Action: Second Edition
% Chapter 03
% Software Installation Simplified

# Software Installation Simplified

## Text Book

![*itmt 495/595 textbook*](images/cover.png "Docker In Action V2 Book Cover Image"){height=350px}

## Chapter 03 - Objectives

- Demonstrate how to identify software
- Demonstrate finding and installing software with Docker Hub
- Demonstrate understanding filesystem isolation
- Explore working with images and layers

## Concept Review

- From chapter 01:
  - What are the two Linux concepts/features that make up a Linux Container?
  - Docker was created in what year/month?
  - Is the focus of Docker containers infrastructure or application deployment?
  - What is a Docker Container image?
  - What is a Docker Container instance?
  - What is the difference between a Linux Container and a Virtual Machine?

## Concept Review 2

- What is `--detached` mode?
- What is a CID?
- What does it mean to link two containers?

## Introduction

![*Figure 3-1*](images/figure3-1.png "Identify what Docker is doing image")

- We will learn the three main ways Docker installs images
  - Using Docker registries
  - Using image files with docker save and docker load
  - Building images with Dockerfiles
- We’ll learn how Docker isolates installed software
  - We’ll be exposed to a new term, a **layer**
  - Layers, an important concept when dealing with images, provide multiple important features

## Identifying Software - 3.1

- In Chapter 02 we learned that Docker creates containers from images
  - An image is a file
  - It holds files that will be available to containers created from it and metadata about the image
  - This metadata contains labels, environment variables, default execution context, the command history for an image, and more
- A named repository is a named bucket of images
  - docker.io/dockerinaction/ch3_hello_registry
  - docker.io is the regsitry host
  - dockerinaction is the org name
  - ch3_hello_registry is the short name for the image

## Using Tags - 3.1.2

- A tag is a way to uniquely identify an image and a convenient way to create useful aliases
  - For example, the Java repository on Docker Hub maintains the following tags:
  - 11-stretch, 11-jdk-stretch, 11.0-stretch, 11.0-jdk-stretch, 11.0.4-stretch, and 11.0.4-jdk-stretch
  - All slightly different versions

## Finding and Installing Software - 3.2

- Docker Hub is the default location for Docker
  - [https://hub.docker.com](https://hub.docker.com "docker hub webpage")
- Red Hat's repo is called [https://quay.io](https://quay.io "Red Hat container repositiry)
  - This can be used with Docker by just giving an explicit URL when you pull a container
  - `docker pull quay.io/dockerinaction/ch3_hello_registry:latest`
  - Amamzon Container Registry
  - Google Container Registry
  - Docker EE and Artifactory Registries
  - Host your own internal private registry (chapter 08)

## Working with images as files - 3.2.2

- If you make a container instance with custom changes you want to save/share you can save it
  - `sudo docker pull busybox:latest`
  - `sudo docker save -o myfile.tar busybox:latest`
- You can load this saved file back in with `docker load`
  - `sudo docker load –i myfile.tar`

## Installing from a Dockerfile - 3.2.4

- A much more compact and robust way is to distribute a `dockerfile`
  - A Dockerfile is a script that describes steps for Docker to take to build a new image
  - Like a recipe
  - Dockerfiles are covered in depth in Chapter 7
  - In this case, you’re not technically installing an image. Instead, you’re following instructions to build an image
  - We use the `docker build` command to build the container from the Dockerfile

## Installation Files and Isolation - 3.3

- Understanding how images are identified, discovered, and installed is a minimum proficiency for a Docker user
- If you understand what files make up a container image you’ll be able to answer more difficult questions:
  - What image properties factor into download and installation speeds?
  - What are all these unnamed images that are listed when I use the docker images command?
  - Why does output from the docker pull command include messages about pulling dependent layers?
  - Where are the files that I wrote to my container’s filesystem?
- Docker uses the term: images
  - Images are really just a collection of layers
  - A layer is set of files and file metadata that is packaged and distributed as an atomic unit

## Images and Layers in Action - 3.3.1

- Let us run these two commands and compare the output
  - (Just use the Docker pull command as we are not running these containers)
  - `sudo docker pull dockerinaction/ch3_myapp`
  - `sudo docker pull dockerinaction/ch3_myotherapp`
- Let us look at the images
  - `sudo docker images`
- To delete an image you need to use the `rmi` command
  - `sudo docker rmi dockerinaction/ch3_myapp`

## Layer relationships - 3.3.2

- The files available to a container are the union of all layers in the lineage of the image that the container was created from
- Here is where the difference between a container and an Virtual Machine really show
  - Layers from different containers can be reused (copies made) between different images
  - Saving download bandwidth
- Because Docker uniquely identifies images and layers, it is able to recognize shared image dependencies between applications and avoid downloading those dependencies again

## Container filesystem abstraction and isolation - 3.3.3

- Programs running inside containers know nothing about image layers
  - From inside a container, the filesystem operates as though it’s not running in a container
  - From the perspective of the container, it has exclusive copies of the files provided by the image
  - This is made possible with something called a union filesystem (UFS)
  - rom the perspective of the container, it has exclusive copies of the files provided by the image
  - This is made possible with something called a union filesystem (UFS)
- A union filesystem is part of a critical set of tools that combine to create effective filesystem isolation
  - The other tools are MNT namespaces
  - The chroot system call

## Namespaces

- The filesystem is used to create mount points on your host’s filesystem that abstract the use of layers
  - The layers created are bundled into Docker image layers
  - Likewise, when a Docker image is installed, its layers are unpacked and appropriately configured for use by the specific filesystem provider chosen for your system
  - The Linux kernel provides a namespace for the MNT system
  - When Docker creates a container, that new container will have its own MNT namespace, and a new mount point will be created for the container to the image
  - `chroot` is used to make the root of the image filesystem the root in the container’s context
  - This prevents anything running inside the container from referencing any other part of the host filesystem

## Benefits - 3.3.4

- The first and perhaps most important benefit of this approach is that common layers need to be installed only once
  - If you install any number of images and they all depend on a common layer, that common layer and all of its parent layers will need to be downloaded or installed only once
  - Layers provide a coarse tool for managing dependencies and separating concerns

## Weaknesses of union filesystems - 3.3.5

- Different filesystems have different rules about file attributes, sizes, names, and characters
  - Union filesystems are in a position where they often need to translate between the rules of different filesystems
  - For example, neither Btrfs nor OverlayFS provides support for the extended attributes that make SELinux work
  - Union filesystems use a pattern called copy-on-write, and that makes implementing memory-mapped files (the mmap system call) difficult
  - The backing filesystem is another pluggable feature of Docker. You can determine which filesystem your installation is using with the info subcommand
  - You could use btrfs or zfs as the storage-driver
  - This is detailed in Chapter 4

## Summary - Part 1 of 2

- The task of installing and managing software on a computer presents a unique set of
challenges
  - This chapter explained how you can use Docker to address them
- The core ideas and features covered by this chapter are as follows:
  - Human users of Docker use repository names to communicate which software they would like Docker to install
  - Docker Hub is the default Docker registry. You can find software on Docker Hub through either the website or the docker command-line program
  - The docker command-line program makes it simple to install software that’s distributed through alternative registries or in other forms

## Summary - Part 2 of 2

- Summary continued
  - The image repository specification includes a registry host field
  - The docker load and docker save commands can be used to load and save images from TAR archives
  - Distributing a Dockerfile with a project simplifies image builds on user machines
  - Images are usually related to other images in parent/child relationships
    - These relationships form layers
  - When we say that we have installed an image, we are saying that we have installed a target image and each image layer in its lineage
  - Structuring images with layers enables layer reuse and saves bandwidth during distribution and storage space on your computer and image distribution servers.

## Deliverable

- If not complete demonstrate the Wordpress 3 container MySQL 1 container node install project
  
## Questions

Any questions?
