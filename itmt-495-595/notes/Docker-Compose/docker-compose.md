% Docker in Action: Second Edition
% Chapter 11
% Services with Docker and Compose

# Services with Docker and Compose

## Text Book

![*itmt 495/595 textbook*](images/cover.png "Docker In Action V2 Book Cover Image"){height=350px}

## Chapter - Objectives

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

- Docker Compose Overview
  - [https://docs.docker.com/compose/](https://docs.docker.com/compose/ "Docker Compose overview website")
  - Compose is a tool for defining and running multi-container Docker applications
  - With Compose, you use a YAML file to configure your application’s services
  - With a single command, you create and start all the services from your configuration

## Compose 3 step process

- Compose works in all environments: production, staging, development, testing, as well as Continuous Integration workflows
- Using Compose is basically a three-step process:
  - Define your app’s environment with a Dockerfile so it can be reproduced anywhere
  - Define the services that make up your app in docker-compose.yml so they can be run together in an isolated environment
  - Run `sudo docker compose up` and the Docker compose command starts and runs your entire app
  - You can alternatively run `sudo docker-compose up` using the docker-compose binary

## Docker Compose YAML file

```yaml
version: "3.9"  # optional since v1.27.0
services:
  web:
    build: .
    ports:
      - "5000:5000"
    volumes:
      - .:/code
      - logvolume01:/var/log
    links:
      - redis
  redis:
    image: redis
volumes:
  logvolume01: {}
```

## Compose with Comments

```yaml
version: "3.9"  # optional since v1.27.0 - but good idea to put it 
services:  # Requried to be second and note the indentation -- that is requried 
  web:  # name of the first docker container
    build: .  # this one means that we are building it from a dockerfile in "."
    ports: # these are the ports we are exposing like -p nodePort
      - "5000:5000"  # 5000 on the host mapped to 5000 in the container Python Flask port
    volumes: # we are mounting volumes  
      - .:/code   # "." the local directory on ourhost system will mount to /code
      - logvolume01:/var/log  # and a new volume created for the logs
    links: # this is the -- link command as we are linking to the redis container
      - redis
  redis:  # note the outdent, we are creating a redis container, a simple docker pull
    image: redis
volumes:  # this is the command needed to create the volume we mentioned in volumes section
  logvolume01: {}  # essentially --volume command
```

## Install Compose

- Docker-Compose is a separate binary that is not part of the docker install.
- [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/ "Docker-compose install webpage")
  - Careful not to use apt-get, as the package might be out of date
- Getting Started
  - [https://docs.docker.com/compose/gettingstarted/](https://docs.docker.com/compose/gettingstarted/ "Getting started website")
  - This will show up how to add the components we need to build a small Python Flask app and a Redis Database to count "hits"

```Dockerfile
FROM python:3.7-alpine
WORKDIR /code
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
EXPOSE 5000
COPY . .
CMD ["flask", "run"]
```

## Summary of Dockerfile

- From chapter 8 your remember the dockerfile syntax.  We will use this once to build a custom docker image for our Python Flask app
- This is because we have application code (our app.py)
  - Build an image starting with the Python 3.7 image
  - Set the working directory to /code
  - Set environment variables used by the flask command
  - Install gcc and other dependencies
  - Copy requirements.txt and install the Python dependencies.
  - Add metadata to the image to describe that the container is listening on port 5000
  - Copy the current directory . in the project to the workdir . in the image
  - Set the default command for the container to flask run.

## Running Docker Compose

- From the `dockercompose` directory:
  - create a `docker-compose.yml` file
  - Add this content
  - Run: `sudo docker-compose up`  and open a browser to http://192.168.33.30:5000

```docker-compose
version: "3.9"
services:
  web:
    build: .
    ports:
      - "5000:5000"
  redis:
    image: "redis:alpine"
```

## Docker Compose Samples

- Let us implement the Wordpress Sample
  - [https://docs.docker.com/compose/wordpress/](https://docs.docker.com/compose/wordpress/ "Wordpress Docker Sample Webpage")
- We can use the `-d` flag to run docker-compose services as a service
  - `sudo docker-compose -d up`
  - This will execute and build every part of your docker-compose.yml file
  - `sudo docker-compose down` deletes and stops containers
  - You can also use the NETWORK header in the docker-compose.yml
  - [https://github.com/compose-spec/compose-spec/blob/master/spec.md#networks-top-level-element](https://github.com/compose-spec/compose-spec/blob/master/spec.md#networks-top-level-element "docker-compose network example webpage")

## Summary

- Docker-compose is a power way to construct not individual containers, but containers and applications grouped as services.
  - Docker-compose allow for building of custom containers as well as deploying stock containers
  - Entire service can be controlled by and up or down command

## Deliverable

- Complete the Wordpress Docker-Compose example
  - [https://docs.docker.com/compose/wordpress/](https://docs.docker.com/compose/wordpress/ "Wordpreses Docker-Compose website")
  - Do not use the default network, but add a network named **frontend** and **backend**

## Questions

Any questions?
