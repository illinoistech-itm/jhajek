% Docker in Action: Second Edition
% Chapter 05
% Single Host Networking

# Single Host Networking

## Text Book

![*itmt 495/595 textbook*](images/cover.png "Docker In Action V2 Book Cover Image"){height=350px}

## Chapter 05 - Objectives

- Discuss Docker networking background
- Demonstrate creating Docker container networks
- Demonstrate the Network-less and host-mode container paradigm
- Demonstrate how to publish services on the ingress network
- Discuss container network caveats

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

## Concept Review 4

- In Linux -- what is a mount point?
- How do Containers use bind mounts to attached other parts of a filesystem to a Container?
- What is an in-memory filesystem in relation to a Container?
- What is a Docker volume?
- Are volumes separate or part of a Container (CID)?
- Do volumes persist after a Container instance has been stopped?  Deleted?

## Introduction

- Former Sun Microsystems CEO, Scott McNealy, once said, "The computer is not the computer, the network, is the computer."
  - Everything is about networking
  - Everything is attached to networking
  - We need to create containers with proper network exposure
- We need to understand how Docker networking interacts with the underlying host

## Basics: Protocols, interfaces, and ports - 5.1.1

- What is a network protocol?
- What is a network interface (NIC)?
  - How do we communicate with network interfaces?
- What is a port?
  - In relation to the network interface?
- What is the default port for:
  - http
  - https
  - MySQL
  - MemCached
  - MongoDB
  - CassandraDB
  - Redis
  - NodeJS

## Bigger Networking Picture: Networks, NAT, and port forwarding - 5.1.2

- 


## Summary - Part 2 of 2

- Summary

## Questions

Any questions?
