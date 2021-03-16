% Docker in Action: Second Edition
% Chapter 02
% Running Docker

# Running Docker

## Text Book

![*itmt 495/595 textbook*](images/cover.png "Docker In Action V2 Book Cover Image"){height=350px}

## Chapter 02 - Objectives

- Running interactive and daemon terminal programs in containers
- Perform basic Docker operations and commands
- Isolating programs from each other and injecting configuration
- Demonstrating running multiple programs in a container
- Demonstrating the container life cycle
- Cleaning up Docker

## Introduction

![*Figure 2-1*](images/figure2-1.png "Three node image")

## Controlling containers: Building a website monitor - 2.1

- Create 3 nodes
  - An NGINX webserver container
    - Port 80
  - A mailer program container
    - Port 33333
  - A monitoring program container

## Controlling Containers

- To create this we need:
  - Create detached and interactive containers
  - List containers on your system
  - View container logs
  - Stop and restart containers
  - Reattach a terminal to a container
  - Detach from an attached container

## Creating and Controlling a new container - 2.1.1

- Docker calls the collection of files and instructions needed to run a software program an image
- In this example, we’re going to download and install an image for NGINX from Docker Hub
  - There are other public and private hosted registries
  - [RedHat Container Registry](https://catalog.redhat.com/software/containers/explore "Red Hat container images website")
  - [Amazon Container Registry](https://aws.amazon.com/ecr/ "Amazon Container Registry website")
- Public containers are just that, public.  
  - Usually the producers of software maintain there official container
  - But not always
  - There are paid and private registries for enterprise assurance

## Run and Install the Containers

- `sudo docker run --detach --name web nginx:latest`
  - The output will be a large serial number or UUID for that containers instance
  - The `--detach` flag runs the docker instance in the background as a daemon
- `sudo docker run -d --name mailer dockerinaction/ch2_mailer`
- Lets run the monitor container in interactive mode
  - `sudo docker run -it --name agent --link web:insideweb --link mailer:insidemailer dockerinaction/ch2_agent`

## Listing, stopping, restarting, and viewing output of containers - 2.1.3

- `sudo docker ps`
  - This will list the running docker processes
- It will list the following:
  - The container ID
  - The image used
  - The command executed in the container
  - The time since the container was created
  - The duration that the container has been running
  - The network ports exposed by the container
  - The name of the container
- `sudo docker logs web` will show any internal logs generated from the containers
  - `-f` flag will follow or watch the logs update in realtime

## Solved problems and the PID namespace - 2.2

- Every running program—or process—on a Linux machine has a unique number called a process identifier (PID)
  - A PID namespace is a set of unique numbers that identify processes
- Docker creates a new PID namespace for each container by default
  - A container’s PID namespace isolates processes in that container from processes in other containers
  - Each container is completely isolated from other containers via its namespace
- But that ports that a container runs on are a system level value in the kernel
  - Not a namespace
  - Two containers cannot listen both on port 80

## A Webserver farm - 2.3

![*Figure 2-2*](images/figure2-2.png "Webserver Farm Diagram")

## Webserver farm

```bash
MAILER_CID=$(docker run -d dockerinaction/ch2_mailer)
WEB_CID=$(docker run -d nginx)
AGENT_CID=$(docker run -d \
 --link $WEB_CID:insideweb \
 --link $MAILER_CID:insidemailer \
 dockerinaction/ch2_agent)
 ```

## Environmental Agnostic Systems

- Docker has three specific features to help build environment-agnostic systems:
  - Read-only filesystems
  - Environment variable injection
  - Volumes
- `sudo docker run -d --name wp --read-only wordpress:5.0.0-php7.2-apache`
- `sudo docker run -d --name wp2 --read-only -v /run/apache2/ --tmpfs /tmp wordpress:5.0.0-php7.2-apache`
  - `sudo docker logs wp2`
- `sudo docker run -d --name wpdb -e MYSQL_ROOT_PASSWORD=ch2demo mysql:5.7`
- `sudo docker run -d --name wp3 --link wpdb:mysql -p 8000:80 --read-only -v /run/apache2/ --tmpfs /tmp wordpress:5.0.0-php7.2-apache`

## Assignment

- Finish complete Wordpress and Container based install
  - Including Environment varialbes for dynamic deployment