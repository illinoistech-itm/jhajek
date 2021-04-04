% Docker in Action: Second Edition
% Chapter 08
% Building images automatically with Dockerfiles

# Building images automatically with Dockerfiles

## Text Book

![*itmt 495/595 textbook*](images/cover.png "Docker In Action V2 Book Cover Image"){height=350px}

## Chapter 08 - Objectives

- Discuss and demonstrate how to deploy automated image packaging with Dockerfiles
- Discuss the purpose of metadata and filesystem instructions
- Demonstrate creating maintainable image builds with arguments and multiple stages
- Demonstrate packaging for multiprocess and durable containers
- Understand the significance of reducing the image attack surface and building trust

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

## Introduction

- A Dockerfile is a text file that contains instructions for building a Docker image
  - The Docker image builder executes the Dockerfile and the instructions can configure or change anything about an image
  - Like what we have been doing from the command line
- Dockerfiles are the most common way to describe how to build a Docker image
- This chapter covers the basics of working with Dockerfile builds
  - The best reasons to use them
  - A lean overview of the instructions
  - How to add future build behavior
- We will use a familiar example that shows how to automate the process of building images with code instead of creating them manually
  - Once an image’s build is defined in code, it is simple to track changes in version control

## Packaging Git with a Dockerfile - 8.1

- Let us create a new directory
  - From that directory create a new file and name the new file **Dockerfile**
  - Let's add this code to the Dockerfile, changing the LABEL information to your own
  
```bash
# An example Dockerfile for installing Git on Ubuntu
FROM ubuntu:latest
LABEL maintainer="dia@allingeek.com"
RUN apt-get update && apt-get install -y git
ENTRYPOINT ["git"]
```

## Summary

- Summary here

## Deliverable

- NA

## Questions

Any questions?
