% Docker in Action: Second Edition
% Chapter 11
% Services with Docker and Compose

# Services with Docker and Compose

## Text Book

![*itmt 495/595 textbook*](images/cover.png "Docker In Action V2 Book Cover Image"){height=350px}

## Chapter 11 - Objectives

- Understanding services and how they relate to containers
- Building declarative environments with Docker Compose and YAML
- Iterating projects with Compose and the deploy command
- Scaling services and cleaning up

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

## Concept Review 5

- Can Docker networks be created separate from containers?
- Describe the default bridge network in Docker
- How does Docker do name resolution?
- How does Docker do IP addressing and routing?
- Can there be multiple Docker networks per system?
- What are the other two Docker network types?
- What is a NodePort and how does it allow forwarded traffic from the host to a container?
- Do Docker bridge networks provide any network firewall or access-control functionality?

## Concept Review 6

- How can Docker limit the amount of memory available to a container?
  - How does this differ from a virtual machine?
  - Is this a quota or used for protection from overprovisioning?
- How are CPUs shared/limited when there is resource contention?

## Concept Review 7

- Which Docker command allows you to create a new customized Docker image?
- When a new Docker image is committed, does the previous configuration stay with the container?
- How is the size of a Docker image determined?
- Which command is used to tag/version Docker images?
- What is the reasoning behind tagging your latest stable build with the **latest** tag

## Concept Review 8

- Explain the purpose of Dockerfiles?

## Introduction

- Managing systems with a small number of components is manageable without much automation
  - But achieving consistency and repeatability is difficult without automation as the system grows
  - Managing modern service architectures is complex and requires automated tooling

## Summary

- 

## Deliverable

- NA

## Questions

Any questions?
