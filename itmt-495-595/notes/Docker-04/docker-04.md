% Docker in Action: Second Edition
% Chapter 04
% Working with storage and volumes

# Working with storage and volumes

## Text Book

![*itmt 495/595 textbook*](images/cover.png "Docker In Action V2 Book Cover Image"){height=350px}

## Chapter 04 - Objectives

- Demonstrate mount points
- Demonstrate how to share data between the host and a container
- Demonstrate how to share data between containers
- Explain the concept of using temporary, in-memory filesystems
- Explain how to managing data with volumes
- Discuss advanced storage with volume plugins

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

## Concept Review 3

- What are the three methods for obtaining Docker Images?
- What is a registry?
- Is a Docker Image a file?
- What is a layer?
- What is a major advantage of filesystem layers in Docker?
- How does the use of namespaces and `chroot` allow for filesystems to work in Docker?

## Introduction

- So far we have run a bunch of containers
  - They have been trivial applications
- What if we want to run a real application?
- What if we had a database?
  - Where would that file be stored?
  - Is it in a file inside the container?
  - What happens to that data when you stop the container or remove the container?
  - Where would you write log files so that they will outlive the container?
  - How would you get access to those logs to troubleshoot a problem?
  - How can other programs such as log digest tools get access to those files?

## File trees and mount points - 4.1

![*Linux Filesystem*](images/linux-filesystem.png "Linux filesystem image")

- Storage devices such as disk partitions or USB disk partitions are attached to specific locations in that tree
- Those locations are called **mount points**
- A mount point defines the location in the tree
  - The access properties to the data at that point (for example, writability)
  - The source of the data mounted at that point (for example, a specific hard disk, USB device, or memory-backed virtual disk)

## Mounts

- Mount points allow software and users to use the file tree in a Linux environment
  - Without knowing exactly how that tree is mapped into specific storage devices
- Logic follows that if different storage devices can be mounted at various points in a file tree, we can mount nonimage-related storage at other points in a container file tree
- That is exactly how containers get access to storage on the host filesystem and share storage between containers
- The best place to start is by understanding the three most common types of storage mounted into containers:
  - Bind mounts
  - In-memory storage
  - Docker volumes

## Storage Types

- These storage types can be used in many ways...
  - Figure 4.2 shows an example of a container filesystem
  - That starts with the files from the image
  - Adds an in-memory tmpfs at `/tmp`
  - bind-mounts a configuration file from the host
  - writes logs into a Docker volume on the host

![*Figure4-2*](images/figure4-2.png "Diagram of common container storage mounts")

## Bind mounts - 4.2

- Bind mounts are mount points used to remount parts of a filesystem tree onto other locations
  - Suppose you’re running a web server that depends on sensitive configuration on the host and emits access logs that need to be forwarded by your log-shipping system
  - You could use Docker to launch the web server in a container
  - Then bind-mount the configuration location as well as the location where you want the web server to write log
  - In Figure 4.3, lets deploy a web server container
  - Let us deploy an log forwarder software container (theoretical)
  - Let us demonstrate how mounts work and how we can share a single file between two containers
  
## Figure 4.3

![*Figure 4.3*](images/figure4-3.png "Host files shared as bind-mounts image")

## Mount and Bind Options

- Lets look at printed page 65, 66, and 67
  - The main thing to capture here is that we are going to mount files from our local filesystem into the Docker Container
  - Then we will set those conf files as read-only (for security)
  - We will also enable the container to write a log file back to our local filesystem from the container
  - But bind mounts are not optimal for general computing (say hosting a database file)

## In-memory storage - 4.3

- Where to store secret or sensitive information?
  - Why not in-memory?
  - Set the type option on the mount flag to tmpfs
  - This is the easiest way to mount a memory-based filesystem into a container’s file tree
  - You can set quotas on this in-memory filesystem

## Sample of in-memory

docker run --rm \
 --mount type=tmpfs,dst=/tmp \
 --entrypoint mount \
 alpine:latest -v

docker run --rm \
 --mount type=tmpfs,dst=/tmp,tmpfs-size=16k,tmpfs-mode=1770 \
 --entrypoint mount \
 alpine:latest -v

## Docker volumes - 4.3

- In VirtualBox we have virtual harddrives or sometimes called 'volumes'
  - This is not that
- Docker volumes are named filesystem trees managed by Docker
  - All operations on Docker volumes can be accomplished using the docker volume subcommand set
  - `docker volume create`
  - `docker volume inspect`
- Let us look at some examples in 4.4.1

## Summary - Part 1 of 2

- This chapter covered mount points in depth, including the following:
  - Mount points allow many filesystems from many devices to be attached to a single file tree. Every container has its own file tree
  - Containers can use bind mounts to attach parts of the host filesystem into a container
  - In-memory filesystems can be attached to a container file tree so that sensitive or temporary data is not written to disk
  - Docker provides anonymous or named storage references called volumes

## Summary - Part 2 of 2

- Volumes can be created, listed, and deleted using the appropriate docker volume subcommand
- Volumes are parts of the host filesystem that Docker mounts into containers at specified locations
- Volumes have life cycles of their own and might need to be periodically cleaned up
- Docker can provide volumes backed by network storage or other more sophisticated tools if the appropriate volume plugin is installed

## Deliverable

- Using the Nginx Docker image [https://hub.docker.com/_/nginx](https://hub.docker.com/_/nginx "nginx docker image link")
  - Create an Nginx load balancer
  - Use a volume mount to mount the necessary configuration files into the container and mount as ro
  - Add a tmpfs mount
  - Create 3 additional Nginx webserver to display hello world sample code provided
    - In the jhajek repo under itmt-495-595: container-lb-sample

## Questions

Any questions?
